//
//  ApiRickAndMortyCharacterLocation.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import Foundation

struct ApiRickAndMortyCharacterLocation: Codable {
    let name: String?
    let url: String
    
    var toDomainModel: RickAndMortyCharacterLocation {
        RickAndMortyCharacterLocation(name: name ?? "", url: URL(string: url))
    }
}
