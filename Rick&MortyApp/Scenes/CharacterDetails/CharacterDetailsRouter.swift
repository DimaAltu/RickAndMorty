//
//  CharacterDetailsRouter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

import UIKit

protocol CharacterDetailsRouter {
    func moveToCharacterDetailsPage(character: RickAndMortyCharacter)
}

final class CharacterDetailsRouterImpl: CharacterDetailsRouter {
    
    private weak var controller: UIViewController?
    
    init(controller: UIViewController?) {
        self.controller = controller
    }
    
    func moveToCharacterDetailsPage(character: RickAndMortyCharacter) {
        let configurator = CharacterDetailsConfiguratorImpl(characterModel: character)
        let vc = CharacterDetailsController(with: configurator)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
