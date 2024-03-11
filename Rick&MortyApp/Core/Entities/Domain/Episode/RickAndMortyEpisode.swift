//
//  RickAndMortyEpisode.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

struct RickAndMortyEpisode {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    var characterIds: [Int] {
        characters.compactMap { Int($0.split(separator: "/").last ?? "") }
    }
}
