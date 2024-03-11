//
//  CharacterDetailsPresenter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 07.03.24.
//

protocol CharacterDetailsView: AnyObject {
    func reloadEpisodesList()
    func showCharactersList()
    func reloadCharactersList()
}

protocol CharacterDetailsPresenter {
    var dataProvider: CharacterDetailsDataProvider { get }
    func didSelectedEpisode(at index: Int)
    func didSelectedCharacter(at index: Int)
}

final class CharacterDetailsPresenterImpl: CharacterDetailsPresenter {
    
    var dataProvider: CharacterDetailsDataProvider {
        CharacterDetailsDataComposer(
            navigationTitle: character.name,
            imageUrl: character.image,
            infoItems: getCharacterDetailsData(),
            episodesListItems: getEpisodesListData(),
            episodeCharacters: getEpisodeCharactersListData()
        )
    }
    
    private typealias CharacterCompletionHandler = ((RickAndMortyCharacter) -> Void)
    
    private weak var view: CharacterDetailsView?
    private var router: CharacterDetailsRouter
    private(set) var character: RickAndMortyCharacter
    private var episodeUseCase: GetEpisodeUseCase
    private var characterUseCase: GetSingleCharacterUseCase

    private var selectedEpisodeIndex: Int?
    private var selectedEpisodeCharacters: [Int: RickAndMortyCharacter?] = [:] {
        didSet {
            view?.reloadCharactersList()
        }
    }
    
    init(view: CharacterDetailsView?,
         router: CharacterDetailsRouter,
         character: RickAndMortyCharacter,
         episodeUseCase: GetEpisodeUseCase,
         characterUseCase: GetSingleCharacterUseCase) {
        self.view = view
        self.router = router
        self.character = character
        self.episodeUseCase = episodeUseCase
        self.characterUseCase = characterUseCase
    }
    
    func didSelectedEpisode(at index: Int) {
        guard selectedEpisodeIndex != index else { return }
        selectedEpisodeCharacters.removeAll(keepingCapacity: false)
        selectedEpisodeIndex = index
        view?.reloadEpisodesList()
        view?.showCharactersList()
        getEpisode(episodeNumber: getSelectedEpisodeNumber(selectedEpisodeIndex: index))
    }
    
    func didSelectedCharacter(at index: Int) {
        let id = dataProvider.episodeCharacters[index].id
        getCharacter(with: id) { [weak self] receivedCharacter in
            self?.router.moveToCharacterDetailsPage(character: receivedCharacter)
        }
    }
    
    //MARK: Private methods
    private func getCharacterDetailsData() -> [CharacterDetailsInfoDataComposer] {
        var items: [CharacterDetailsInfoDataComposer] = []
        items.append(CharacterDetailsInfoDataComposer(
            systemImage: character.status == .Alive ? "heart.fill" : "heart",
            title: "Status",
            description: character.status.rawValue))
        items.append(CharacterDetailsInfoDataComposer(
            systemImage: "brain.head.profile",
            title: "Species",
            description: character.species))
        items.append(CharacterDetailsInfoDataComposer(
            systemImage: "figure.dress.line.vertical.figure",
            title: "Gender",
            description: character.gender.rawValue))
        items.append(CharacterDetailsInfoDataComposer(
            systemImage: "flag.fill",
            title: "Origin",
            description: character.origin.name))
        if let location = character.location {
            items.append(CharacterDetailsInfoDataComposer(
                systemImage: "mappin.and.ellipse",
                title: "Location",
                description: location.name))
        }
        return items
    }
    
    private func getEpisodesListData() -> [CharacterDetailsEpisodeItemDataComposer] {
        character.episode.enumerated().map {
            CharacterDetailsEpisodeItemDataComposer(
                title: String(describing: $0.element.split(separator: "/").last ?? ""),
                isSelected: selectedEpisodeIndex == $0.offset
            )
        }
    }
    
    private func getEpisodeCharactersListData() -> [CharacterDetailsEpisodeCharacterDataComposer] {
        selectedEpisodeCharacters.map { key, value in
            CharacterDetailsEpisodeCharacterDataComposer(imageUrl: value?.image ?? "", id: key, isLoaded: value != nil)
        }
    }
    
    private func getSelectedEpisodeNumber(selectedEpisodeIndex: Int) -> Int {
        let number = character.episode[selectedEpisodeIndex].split(separator: "/").last ?? ""
        return Int(number) ?? 0
    }
}

//MARK: Service Calls
extension CharacterDetailsPresenterImpl {
    private func getEpisode(episodeNumber: Int) {
        Task { @MainActor in
            let result = await episodeUseCase.getEpisodeInfo(episodeNumber: episodeNumber)
            switch result {
            case .success(let episode):
                episode.characterIds.forEach { id in
                    selectedEpisodeCharacters.updateValue(nil, forKey: id)
                    getCharacter(with: id) { [weak self] receivedCharacter in
                        self?.selectedEpisodeCharacters.updateValue(receivedCharacter, forKey: id)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getCharacter(with id: Int, completionHandler: @escaping CharacterCompletionHandler) {
        Task { @MainActor in
            let result = await characterUseCase.getCharacters(characterId: id)
            switch result {
            case .success(let character):
                completionHandler(character)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
