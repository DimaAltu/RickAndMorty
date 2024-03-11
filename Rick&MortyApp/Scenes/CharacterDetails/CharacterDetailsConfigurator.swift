//
//  CharacterDetailsConfigurator.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

protocol CharacterDetailsConfigurator {
    func configure(controller: CharacterDetailsController)
}

final class CharacterDetailsConfiguratorImpl: CharacterDetailsConfigurator {
    
    let characterModel: RickAndMortyCharacter
    
    init(characterModel: RickAndMortyCharacter) {
        self.characterModel = characterModel
    }
    
    func configure(controller: CharacterDetailsController) {
        let presenter = CharacterDetailsPresenterImpl(
            view: controller,
            router: CharacterDetailsRouterImpl(
                controller: controller
            ),
            character: characterModel,
            episodeUseCase: GetEpisodeUseCaseImpl(
                gateway: ApiGetEpisodeGateway()
            ),
            characterUseCase: GetSingleCharacterUseCaseImpl(
                gateway: ApiGetSingleCharacterGateway()
            )
        )
        controller.presenter = presenter
        
    }
}
