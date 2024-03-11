//
//  RickAndMortyCharacter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 06.03.24.
//

import Foundation

struct RickAndMortyCharactersResult {
    let info: RickAndMortyCharactersInfo
    let results: [RickAndMortyCharacter]
}

struct RickAndMortyCharactersInfo {
    let count: Int
    let pages: Int
    let next: String
    let prev: String
}

struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: RickAndMortyCharacterStatusType
    let species: String
    let type: String
    let gender: RickAndMortyCharacterGenderType
    let origin: RickAndMortyCharacterOrigin
    let location: RickAndMortyCharacterLocation?
    let image: String
    let episode: [String]
    let url: URL?
    let created: String
}

enum RickAndMortyCharacterStatusType: String, CaseIterable, Codable {
    case Alive
    case Dead
    case unknown
}

enum RickAndMortyCharacterGenderType: String, CaseIterable, Codable {
    case Female
    case Male
    case Genderless
    case unknown
}

struct RickAndMortyCharacterOrigin: Codable {
    let name: String
    let url: URL?
}

struct RickAndMortyCharacterLocation: Codable {
    let name: String
    let url: URL?
}
