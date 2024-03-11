//
//  GetEpisodeUseCaseSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class GetEpisodeGatewaySpy: GetEpisodeGateway {
    func getEpisodeInfo(episodeNumber: Int) async -> Rick_MortyApp.GetEpisodeCompletion {
        .failure(.unknown)
    }
}

final class RickAndMortyEpisodeUseCaseSpy: GetEpisodeUseCase {
    
    var gateway: Rick_MortyApp.GetEpisodeGateway = GetEpisodeGatewaySpy()
    
    var returnedValue: GetEpisodeCompletion?
    
    init(returnedValue: GetEpisodeCompletion? = nil) {
        self.returnedValue = returnedValue
    }
    
    func getEpisodeInfo(episodeNumber: Int) async -> Rick_MortyApp.GetEpisodeCompletion {
        returnedValue ?? .success(.getDefaultEpisode(with: 13))
    }
}

