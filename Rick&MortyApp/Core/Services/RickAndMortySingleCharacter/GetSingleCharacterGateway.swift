//
//  GetSingleCharacterGateway.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

import Foundation

struct GetSingleCharacterEndpoint: Endpoint {
    var host: String = "rickandmortyapi.com"
    var path: String = "/api/character"
    var query: [String : Any]?
}

typealias GetSingleCharactersCompletion = Result<RickAndMortyCharacter, RequestError>

protocol GetSingleCharacterGateway {
    func getCharacter(characterId: Int) async -> GetSingleCharactersCompletion
}

class ApiGetSingleCharacterGateway: HTTPClient, GetSingleCharacterGateway {
    func getCharacter(characterId: Int) async -> GetSingleCharactersCompletion {
        var endpoint = GetSingleCharacterEndpoint()
        endpoint.path = endpoint.path + "/\(characterId)"
        let result = await sendRequest(
            endpoint: endpoint,
            responseModel: ApiRickAndMortyCharacter.self
        )
        return result.map { $0.toDomainModel }
    }
}
