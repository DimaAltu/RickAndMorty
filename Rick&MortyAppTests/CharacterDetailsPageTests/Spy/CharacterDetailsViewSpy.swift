//
//  CharacterDetailsViewSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

class CharacterDetailsViewSpy: CharacterDetailsView {
    
    private(set) var episodesListIsReloaded = false
    private(set) var characterListIsReloaded = false
    private(set) var characterListIsVisible = false
    
    
    func reloadEpisodesList() {
        episodesListIsReloaded = true
    }
    
    func showCharactersList() {
        characterListIsVisible = true
    }
    
    func reloadCharactersList() {
        characterListIsReloaded = true
    }
}
