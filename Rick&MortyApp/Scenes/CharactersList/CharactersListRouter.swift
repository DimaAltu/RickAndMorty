//
//  CharactersListRouter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

import UIKit

protocol CharactersListRouter {
    func moveToDetailsPage(characterModel: RickAndMortyCharacter)
}

final class CharactersListRouterImpl: CharactersListRouter {
    
    private weak var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    func moveToDetailsPage(characterModel: RickAndMortyCharacter) {
        let conf = CharacterDetailsConfiguratorImpl(characterModel: characterModel)
        let vc = CharacterDetailsController(with: conf)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
