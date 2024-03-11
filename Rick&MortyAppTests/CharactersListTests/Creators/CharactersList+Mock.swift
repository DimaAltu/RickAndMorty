//
//  CharactersList+Mock.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

extension RickAndMortyCharactersResult {
    static var defaultSuccessResponseEmptyResult: RickAndMortyCharactersResult = {
        .init(info: RickAndMortyCharactersInfo(count: 0, pages: 0, next: "", prev: ""), results: [])
    }()
    
    static var successResponseWith20Items: RickAndMortyCharactersResult = {
        let results = (1...20).map {
            RickAndMortyCharacter(
                id: $0,
                name: "Name",
                status: .Alive,
                species: "",
                type: "",
                gender: .Genderless,
                origin: .init(name: "", url: nil),
                location: .init(name: "", url: nil),
                image: "",
                episode: [],
                url: nil,
                created: "")
        }
        return .init(info: RickAndMortyCharactersInfo(count: 0, pages: 0, next: "", prev: ""), results: results)
    }()
    
    static func getSuccessResponse(with items: [RickAndMortyCharacter]) -> RickAndMortyCharactersResult {
        .init(
            info: RickAndMortyCharactersInfo(count: 0, pages: 0, next: "", prev: ""),
            results: items
        )
    }
    
    static func getSuccessResponse(with items: [RickAndMortyCharacter], nextURL: String) -> RickAndMortyCharactersResult {
        .init(info: RickAndMortyCharactersInfo(count: 0, pages: 0, next: nextURL, prev: ""), results: items)
    }
}
