//
//  CharactersListModels.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

//MARK: Filtering
struct FilterItemModel<T> {
    var element: T
    var isSelected: Bool
}

struct CharacterGenderFilterMenuItemModel {
    var title: String
    var image: String
    var filterType: [FilterItemModel<RickAndMortyCharacterGenderType>]
}

struct CharacterStatusFilterMenuItemModel {
    var title: String
    var image: String
    var filterType: [FilterItemModel<RickAndMortyCharacterStatusType>]
}
