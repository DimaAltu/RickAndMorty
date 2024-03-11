//
//  CharactersListRouterSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class CharactersListRouterSpy: CharactersListRouter {
    
    private(set) var didMovedToDetailsPage = false
    private(set) var characterModel: RickAndMortyCharacter?
    
    
    func moveToDetailsPage(characterModel: RickAndMortyCharacter) {
        didMovedToDetailsPage = true
        self.characterModel = characterModel
    }
    
}
