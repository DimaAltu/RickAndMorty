//
//  CharactersRequestModel.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

import Foundation

struct CharactersRequestModel: Encodable {
    let page: String?
    
    init(page: String?) {
        self.page = page
    }
}
