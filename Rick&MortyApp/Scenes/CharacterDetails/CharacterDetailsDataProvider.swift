//
//  CharacterDetailsDataProvider.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

//MARK: Main Data Provider
protocol CharacterDetailsDataProvider {
    var navigationTitle: String { get }
    var imageUrl: String { get }
    var infoTitle: String { get }
    var infoItems: [CharacterDetailsInfoDataProvider] { get }
    var episodesListItems: [CharacterDetailsEpisodeItemDataProvider] { get }
    var episodeCharacters: [CharacterDetailsEpisodeCharacterDataProvider] { get }
}

struct CharacterDetailsDataComposer: CharacterDetailsDataProvider {
    var navigationTitle: String
    var imageUrl: String
    var infoTitle: String = "detail.character.info.title".localizedValue()
    var infoItems: [CharacterDetailsInfoDataProvider]
    var episodesListItems: [CharacterDetailsEpisodeItemDataProvider]
    var episodeCharacters: [CharacterDetailsEpisodeCharacterDataProvider]
}

//MARK: Info Items
protocol CharacterDetailsInfoDataProvider {
    var systemImage: String { get }
    var title: String { get }
    var description: String { get }
}

struct CharacterDetailsInfoDataComposer: CharacterDetailsInfoDataProvider {
    var systemImage: String
    var title: String
    var description: String
}

//MARK: Episode Items
protocol CharacterDetailsEpisodeItemDataProvider {
    var title: String { get }
    var isSelected: Bool { get }
}

struct CharacterDetailsEpisodeItemDataComposer: CharacterDetailsEpisodeItemDataProvider {
    var title: String
    var isSelected: Bool
}

//MARK: Character Items
protocol CharacterDetailsEpisodeCharacterDataProvider {
    var imageUrl: String { get }
    var id: Int { get }
    var isLoaded: Bool { get }
}

struct CharacterDetailsEpisodeCharacterDataComposer: CharacterDetailsEpisodeCharacterDataProvider {
    var imageUrl: String
    var id: Int
    var isLoaded: Bool
}
