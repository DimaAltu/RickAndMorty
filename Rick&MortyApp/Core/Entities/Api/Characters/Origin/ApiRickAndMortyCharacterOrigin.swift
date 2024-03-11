//
//  ApiRickAndMortyCharacterOrigin.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import Foundation

struct ApiRickAndMortyCharacterOrigin: Codable {
    let name: String
    let url: String
    
    var toDomainModel: RickAndMortyCharacterOrigin {
        RickAndMortyCharacterOrigin(name: name, url: URL(string: url))
    }
}
