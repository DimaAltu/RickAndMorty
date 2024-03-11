//
//  ApiRickAndMortyEpisode.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

struct ApiRickAndMortyEpisode: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    private enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case id
        case name
        case episode
        case characters
        case url
        case created
    }
    
    var toDomainModel: RickAndMortyEpisode {
        .init(
            id: id,
            name: name,
            airDate: airDate,
            episode: episode,
            characters: characters,
            url: url,
            created: created
        )
    }
}
