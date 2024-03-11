//
//  RickAndMortyCharactersUseCase.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 05.03.24.
//

protocol GetCharactersUseCase {
    var gateway: GetCharactersGateway { get }
    func getCharacters(request: CharactersRequestModel?) async -> GetCharactersCompletion
}

final class GetCharactersUseCaseImpl: GetCharactersUseCase {
    
    var gateway: GetCharactersGateway
    
    init(gateway: GetCharactersGateway) {
        self.gateway = gateway
    }
    
    func getCharacters(request: CharactersRequestModel?) async -> GetCharactersCompletion {
        let result = await gateway.getCharacters(request: request)
        return switch result {
        case .success(let success): .success(success)
        case .failure(let failure): .failure(failure)
        }
    }
}
