//
//  GetSingleCharacterUseCaseSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class GetSingleCharacterGatewaySpy: GetSingleCharacterGateway {
    func getCharacter(characterId: Int) async -> GetSingleCharactersCompletion {
        .failure(.unknown)
    }
}

final class GetSingleCharacterUseCaseSpy: GetSingleCharacterUseCase {
    
    var gateway: Rick_MortyApp.GetSingleCharacterGateway = GetSingleCharacterGatewaySpy()
    
    var returnedResult: GetSingleCharactersCompletion?
    
    init(returnedResult: GetSingleCharactersCompletion? = nil) {
        self.returnedResult = returnedResult
    }
    
    func getCharacters(characterId: Int) async -> Rick_MortyApp.GetSingleCharactersCompletion {
        returnedResult ?? .success(.characterNamedRicky1)
    }
}
