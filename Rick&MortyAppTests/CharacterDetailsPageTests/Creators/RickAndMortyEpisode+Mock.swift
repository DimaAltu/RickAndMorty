//
//  RickAndMortyEpisode+Mock.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

extension RickAndMortyEpisode {
    
    static func getDefaultEpisode(with id: Int) -> RickAndMortyEpisode {
        .init(id: id, name: "Default Episode", airDate: "nono", episode: "nono", characters: [], url: "", created: "")
    }
    
}
