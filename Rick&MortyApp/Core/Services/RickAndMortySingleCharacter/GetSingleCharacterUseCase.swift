//
//  GetSingleCharacterUseCase.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

protocol GetSingleCharacterUseCase {
    var gateway: GetSingleCharacterGateway { get }
    func getCharacters(characterId: Int) async -> GetSingleCharactersCompletion
}

final class GetSingleCharacterUseCaseImpl: GetSingleCharacterUseCase {
    
    var gateway: GetSingleCharacterGateway
    
    init(gateway: GetSingleCharacterGateway) {
        self.gateway = gateway
    }
    
    func getCharacters(characterId: Int) async -> GetSingleCharactersCompletion {
        let result = await gateway.getCharacter(characterId: characterId)
        return switch result {
        case .success(let success): .success(success)
        case .failure(let failure): .failure(failure)
        }
    }
}
