//
//  ApiRickAndMortyCharacter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

import Foundation

struct ApiRickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ApiRickAndMortyCharacterOrigin
    let location: ApiRickAndMortyCharacterLocation?
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var toDomainModel: RickAndMortyCharacter {
        RickAndMortyCharacter(
            id: id,
            name: name,
            status: RickAndMortyCharacterStatusType(rawValue: status) ?? .unknown,
            species: species,
            type: type,
            gender: RickAndMortyCharacterGenderType(rawValue: gender) ?? .unknown,
            origin: origin.toDomainModel,
            location: location?.toDomainModel,
            image: image,
            episode: episode,
            url: URL(string: url),
            created: created)
    }
}
