//
//  CharacterDetailsTests.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import XCTest
@testable import Rick_MortyApp

final class CharacterDetailsTests: XCTestCase {
    var sut: CharacterDetailsPresenterImpl!
    var router: CharacterDetailsRouterSpy!
    var view: CharacterDetailsViewSpy!
    var episodeUseCase: RickAndMortyEpisodeUseCaseSpy!
    var characterUseCase: GetSingleCharacterUseCaseSpy!
    
    override func setUp() {
        super.setUp()
        router = CharacterDetailsRouterSpy()
        view = CharacterDetailsViewSpy()
        episodeUseCase = RickAndMortyEpisodeUseCaseSpy()
        characterUseCase = GetSingleCharacterUseCaseSpy()

        sut = CharacterDetailsPresenterImpl(
            view: view,
            router: router,
            character: .characterNamedRicky1,
            episodeUseCase: episodeUseCase,
            characterUseCase: characterUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        router = nil
        view = nil
        episodeUseCase = nil
        characterUseCase = nil
    }
}
