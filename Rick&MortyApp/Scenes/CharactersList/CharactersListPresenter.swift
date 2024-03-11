//
//  CharactersListPresenter.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 04.03.24.
//

import Foundation

protocol CharactersListView: AnyObject {
    func reloadData()
    func reloadFilterData()
    func startAnimating()
    func stopAnimating()
}

protocol CharactersListPresenter {
    func viewDidLoad()
    func getCharacters()
    var searchedText: String? { get set }
    var dataProvider: CharactersListDataProvider { get }
    var viewState: CharactersListViewStates { get set }
    func didSelectedGenderFilter(type: RickAndMortyCharacterGenderType)
    func didSelectedStatusFilter(type: RickAndMortyCharacterStatusType)
    func didTappedCharacter(at index: Int)
}

enum CharactersListViewStates: Equatable {
    case loading
    case loaded
    case empty
    case error(String)
}

final class CharactersListPresenterImpl: CharactersListPresenter {
    
    var charactersList: [RickAndMortyCharacter] = []
    var filteredCharacterList: [RickAndMortyCharacter] = []
    var dataProvider: CharactersListDataProvider {
        CharactersListDataComposer(
            characterItemsDataProvider: getCharactersViewModels(),
            selectedGenderFilter: selectedGenderFilter,
            selectedStatusFilter: selectedStatusFilter
        )
    }
    var viewState: CharactersListViewStates = .loading {
        didSet {
            switch viewState {
            case .loading:
                view?.startAnimating()
            case .loaded:
                view?.stopAnimating()
                view?.reloadData()
            case .empty:
                view?.reloadData()
                view?.stopAnimating()
            case .error(_):
                view?.reloadData()
                view?.stopAnimating()
            }
        }
    }
    var selectedGenderFilter: RickAndMortyCharacterGenderType?
    var selectedStatusFilter: RickAndMortyCharacterStatusType?
    var searchedText: String? {
        didSet {
            reloadData()
        }
    }
    
    private var nextPage: String? = nil
    private let charactersUseCase: GetCharactersUseCase
    private weak var view: CharactersListView?
    private var router: CharactersListRouter
    
    init(charactersUseCase: GetCharactersUseCase, 
         view: CharactersListView?,
         router: CharactersListRouter) {
        self.charactersUseCase = charactersUseCase
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        viewState = .loading
        getCharacters()
    }
    
    func didSelectedGenderFilter(type: RickAndMortyCharacterGenderType) {
        selectedGenderFilter = selectedGenderFilter == type ? nil : type
        view?.reloadFilterData()
        reloadData()
    }
    
    func didSelectedStatusFilter(type: RickAndMortyCharacterStatusType) {
        selectedStatusFilter = selectedStatusFilter == type ? nil : type
        view?.reloadFilterData()
        reloadData()
    }
    
    func didTappedCharacter(at index: Int) {
        let selectedCharacter = filteredCharacterList[index]
        router.moveToDetailsPage(characterModel: selectedCharacter)
    }
    
    //MARK: Private methods
    private func getCharactersViewModels() -> [CharactersListItemDataProvider] {
        filteredCharacterList.map { CharactersListItemDataComposer(title: $0.name, imageUrl: $0.image) }
    }
    
    private func reloadData() {
        filteredCharacterList = getSearchedCharacterList(by: searchedText)
        viewState = filteredCharacterList.isEmpty ? .empty : .loaded
    }
}

//MARK: Service Call
extension CharactersListPresenterImpl {
    func getCharacters() {
        guard searchedText?.isEmpty == true || searchedText == nil else { return }
        Task { @MainActor in
            let result = await charactersUseCase.getCharacters(
                request: CharactersRequestModel(
                    page: nextPage)
            )
            switch result {
            case .success(let success):
                nextPage = URL(string: success.info.next)?.valueOf("page")
                charactersList.append(contentsOf: success.results)
                filteredCharacterList = getSearchedCharacterList(by: searchedText)
                viewState = filteredCharacterList.isEmpty ? .empty : .loaded
                await saveReceivedCharacters(characters: success.results)
            case .failure(let failure):
                await retrieveCharactersFromCache()
            }
        }
    }
    
    private func retrieveCharactersFromCache() async {
        let result = await getCachedCharacters()
        charactersList = result
        filteredCharacterList = getSearchedCharacterList(by: searchedText)
        viewState = filteredCharacterList.isEmpty ? .empty : .loaded
    }
}

//MARK: Caching Data
extension CharactersListPresenterImpl {
    private func saveReceivedCharacters(characters: [RickAndMortyCharacter]) async {
        await CacheManager.shared.saveCharacters(
            characters: characters.reduce(into: [Int: RickAndMortyCharacter](), { $0[$1.id] = $1 })
        )
    }
    
    private func getCachedCharacters() async -> [RickAndMortyCharacter] {
        return await CacheManager.shared.loadCharacters().sorted(by: { $0.key < $1.key }).map { $0.value }
    }
}

//MARK: Filtering
extension CharactersListPresenterImpl {
    private func getSearchedCharacterList(by searchedText: String?) -> [RickAndMortyCharacter] {
        guard let searchedText, !searchedText.isEmpty else {
            return getFilteredCharacterList(items: charactersList)
        }
        let filteredModelsBySearchedText = charactersList.filter { $0.name.localizedCaseInsensitiveContains(searchedText) }
        let filteredModelsByTypes = getFilteredCharacterList(items: filteredModelsBySearchedText)
        return filteredModelsByTypes
    }
    
    private func getFilteredCharacterList(items: [RickAndMortyCharacter]) -> [RickAndMortyCharacter] {
        var returnedValue = items
        if let selectedGenderFilter {
            returnedValue = returnedValue.filter { $0.gender == selectedGenderFilter }
        }
        if let selectedStatusFilter {
            returnedValue = returnedValue.filter { $0.status == selectedStatusFilter }
        }
        return returnedValue
    }
}
