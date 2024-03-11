//
//  RickAndMortyEpisodeGateway.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

import Foundation

struct GetEpisodeEndpoint: Endpoint {
    var host: String = "rickandmortyapi.com"
    var path: String = "/api/episode"
    var query: [String : Any]?
}

typealias GetEpisodeCompletion = Result<RickAndMortyEpisode, RequestError>

protocol GetEpisodeGateway {
    func getEpisodeInfo(episodeNumber: Int) async -> GetEpisodeCompletion
}

final class ApiGetEpisodeGateway: HTTPClient, GetEpisodeGateway {
    func getEpisodeInfo(episodeNumber: Int) async -> GetEpisodeCompletion {
        var endpoint = GetEpisodeEndpoint()
        endpoint.path = endpoint.path + "/\(episodeNumber)"
        let result = await sendRequest(
            endpoint: endpoint,
            responseModel: ApiRickAndMortyEpisode.self
        )
        return result.map { $0.toDomainModel }
    }
}
