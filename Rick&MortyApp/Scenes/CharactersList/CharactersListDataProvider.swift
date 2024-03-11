//
//  CharactersListDataProvider.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

//MARK: Main Data Provider
protocol CharactersListDataProvider {
    var characterItemsDataProvider: [CharactersListItemDataProvider] { get }
    var genderFilerModel: CharacterGenderFilterMenuItemModel { get }
    var statusFilterModel: CharacterStatusFilterMenuItemModel { get }
    var emptyFilterViewTitle: String { get }
    var searchPlaceholder: String { get }
    var searchCancelTitle: String { get }
    var navTitle: String { get }
    var filterButtonTitle: String { get }
}

struct CharactersListDataComposer: CharactersListDataProvider {
    var characterItemsDataProvider: [CharactersListItemDataProvider]
    var genderFilerModel: CharacterGenderFilterMenuItemModel {
        let filterTypes: [FilterItemModel<RickAndMortyCharacterGenderType>] = RickAndMortyCharacterGenderType.allCases.map {
            .init(element: $0, isSelected: selectedGenderFilter == $0 )
        }
        return CharacterGenderFilterMenuItemModel(
            title: "Gender",
            image: "person.fill",
            filterType: filterTypes
        )
    }
    var statusFilterModel: CharacterStatusFilterMenuItemModel {
        let filterTypes: [FilterItemModel<RickAndMortyCharacterStatusType>] = RickAndMortyCharacterStatusType.allCases.map {
            .init(element: $0, isSelected: selectedStatusFilter == $0 )
        }
        return CharacterStatusFilterMenuItemModel(
            title: "Status",
            image: "info.circle",
            filterType: filterTypes
        )
    }
    var emptyFilterViewTitle: String { "home.search.no.result.title".localizedValue() }
    var searchPlaceholder: String { "home.search.placeholder.title".localizedValue() }
    var searchCancelTitle: String { "home.search.cancel.title".localizedValue() }
    var navTitle: String { "welcome.controller.title".localizedValue() }
    var filterButtonTitle: String { "home.filter.button.title".localizedValue() }
    var selectedGenderFilter: RickAndMortyCharacterGenderType?
    var selectedStatusFilter: RickAndMortyCharacterStatusType?
}


//MARK: Single Item
protocol CharactersListItemDataProvider {
    var title: String { get }
    var imageUrl: String { get }
}

struct CharactersListItemDataComposer: CharactersListItemDataProvider {
    var title: String
    var imageUrl: String
}
