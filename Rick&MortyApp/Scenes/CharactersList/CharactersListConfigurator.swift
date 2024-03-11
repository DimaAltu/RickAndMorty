//
//  CharactersListConfigurator.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

protocol CharactersListConfigurator {
    func configure(controller: CharactersListController)
}

final class CharactersListConfiguratorImpl: CharactersListConfigurator {
    func configure(controller: CharactersListController) {
        let charactersUseCase = GetCharactersUseCaseImpl(
            gateway: ApiGetCharactersGateway()
        )
        let router = CharactersListRouterImpl(
            controller: controller
        )
        let presenter: CharactersListPresenter = CharactersListPresenterImpl(
            charactersUseCase: charactersUseCase,
            view: controller,
            router: router
        )
        controller.presenter = presenter
    }
}
