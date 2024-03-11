//
//  RickAndMortyCharactersUseCaseSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class RickAndMortyCharactersGatewaySpy: GetCharactersGateway {
    func getCharacters(request: Rick_MortyApp.CharactersRequestModel?) async -> GetCharactersCompletion {
        .failure(RequestError.noResponse)
    }
}

final class RickAndMortyCharactersUseCaseSpy: GetCharactersUseCase {
    
    var gateway: GetCharactersGateway = RickAndMortyCharactersGatewaySpy()
    
    var requestModel: CharactersRequestModel?

    var returnedResult: GetCharactersCompletion
    
    init(returnedResult: GetCharactersCompletion) {
        self.returnedResult = returnedResult
    }
    
    func getCharacters(request: CharactersRequestModel?) async -> GetCharactersCompletion {
        requestModel = request
        return returnedResult
    }
}
