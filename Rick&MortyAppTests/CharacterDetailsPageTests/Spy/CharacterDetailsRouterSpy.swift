//
//  CharacterDetailsRouterSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class CharacterDetailsRouterSpy: CharacterDetailsRouter {
    
    private(set) var movedToCharacterDetailsPage = false
    
    func moveToCharacterDetailsPage(character: Rick_MortyApp.RickAndMortyCharacter) {
        movedToCharacterDetailsPage = true
    }
}
