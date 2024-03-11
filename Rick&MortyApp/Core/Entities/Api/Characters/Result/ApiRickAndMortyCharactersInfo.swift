//
//  ApiRickAndMortyCharactersInfo.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

struct ApiRickAndMortyCharactersInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    var toDomainModel: RickAndMortyCharactersInfo {
        RickAndMortyCharactersInfo(
            count: count,
            pages: pages,
            next: next ?? "",
            prev: prev ?? ""
        )
    }
}
