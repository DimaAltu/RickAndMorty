//
//  RickAndMortyCharactersGateway.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 05.03.24.
//

import Foundation

struct GetCharactersEndpoint: Endpoint {
    var host: String = "rickandmortyapi.com"
    var path: String = "/api/character"
    var query: [String : Any]?
}

typealias GetCharactersCompletion = Result<RickAndMortyCharactersResult, RequestError>

protocol GetCharactersGateway {
    func getCharacters(request: CharactersRequestModel?) async -> GetCharactersCompletion
}

final class ApiGetCharactersGateway: HTTPClient, GetCharactersGateway {
    func getCharacters(request: CharactersRequestModel?) async -> GetCharactersCompletion {
        let endpoint = GetCharactersEndpoint(query: request.jsonDictionary)
        let result = await sendRequest(
            endpoint: endpoint,
            responseModel: ApiRickAndMortyCharactersResult.self
        )
        return result.map { $0.toDomainModel }
    }
}
