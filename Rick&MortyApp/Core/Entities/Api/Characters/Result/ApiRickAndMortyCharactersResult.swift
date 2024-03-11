//
//  ApiRickAndMortyCharactersResult.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

struct ApiRickAndMortyCharactersResult: Codable {
    let info: ApiRickAndMortyCharactersInfo
    let results: [ApiRickAndMortyCharacter]
    
    var toDomainModel: RickAndMortyCharactersResult {
        .init(info: info.toDomainModel,
              results: results.map { $0.toDomainModel })
    }
}
