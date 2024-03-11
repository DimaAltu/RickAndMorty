//
//  RickAndMortyEpisodeUseCase.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

protocol GetEpisodeUseCase {
    var gateway: GetEpisodeGateway { get }
    func getEpisodeInfo(episodeNumber: Int) async -> GetEpisodeCompletion
}

final class GetEpisodeUseCaseImpl: GetEpisodeUseCase {
    
    var gateway: GetEpisodeGateway
    
    init(gateway: GetEpisodeGateway) {
        self.gateway = gateway
    }
    
    func getEpisodeInfo(episodeNumber: Int) async -> GetEpisodeCompletion {
        let result = await gateway.getEpisodeInfo(episodeNumber: episodeNumber)
        return switch result {
        case .success(let success): .success(success)
        case .failure(let failure): .failure(failure)
        }
    }
}
