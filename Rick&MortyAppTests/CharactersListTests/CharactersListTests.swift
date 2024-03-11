//
//  CharactersListTests.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import XCTest
@testable import Rick_MortyApp

final class CharactersListTests: XCTestCase {
    
    var sut: CharactersListPresenterImpl!
    var router: CharactersListRouterSpy!
    var view: CharactersListViewSpy!
    var charactersUseCase: RickAndMortyCharactersUseCaseSpy!
    
    override func setUp() {
        super.setUp()
        charactersUseCase = .init(returnedResult: .success(.defaultSuccessResponseEmptyResult))
        router = CharactersListRouterSpy()
        view = CharactersListViewSpy()
        sut = CharactersListPresenterImpl(
            charactersUseCase: charactersUseCase,
            view: view,
            router: router
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        router = nil
        view = nil
        charactersUseCase = nil
    }
    
    func test_afterViewDidLoad_shouldShowLoader() {
        sut.viewDidLoad()
        XCTAssertTrue(view.isLoaderAnimating, "After ViewDidLoad Loader is Still visible")
    }
    
    func test_afterGetCharacter_Success_ShouldReloadList() async {
        let expectation = XCTestExpectation(description: "Characters loaded successfully")
        charactersUseCase.returnedResult = .success(.defaultSuccessResponseEmptyResult)
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        XCTAssertTrue(view.dataIsReloaded, "List Is not reloaded")
        XCTAssertEqual(sut.viewState, CharactersListViewStates.empty, "after getCharacters method success viewState is not set as .empty")
    }
    
    func test_afterGetCharacters_Failure_shouldShowErrorState() async {
        let expectation = XCTestExpectation(description: "Characters loaded with failure")
        let error = RequestError.invalidURL //Any Error Possible
        charactersUseCase.returnedResult = .failure(error)
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        XCTAssertTrue(view.dataIsReloaded, "List Is not reloaded")
        XCTAssertFalse(view.isLoaderAnimating, "Loader is Animating")
        XCTAssertEqual(sut.viewState, CharactersListViewStates.error(error.localizedDescription),
                       "after getCharacters method failure, error viewState is not set, or error Text is wrong")
    }
    
    func test_afterGetCharactersSuccess_withEmptyList_shouldShowEmptyView() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        charactersUseCase.returnedResult = .success(.defaultSuccessResponseEmptyResult)
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        XCTAssertTrue(view.dataIsReloaded, "List Is not reloaded")
        XCTAssertFalse(view.isLoaderAnimating, "Loader is Animating")
        XCTAssertEqual(sut.viewState, CharactersListViewStates.empty,
                       "after getCharacters method success with empty characters, empty ViewState is not set and emoty View Is not visible")
    }
    
    func test_afterGetCharactersSuccess_showedItemsCountEquals_withReceivedItemsCount() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        charactersUseCase.returnedResult = .success(.successResponseWith20Items)
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        XCTAssertTrue(view.dataIsReloaded, "List Is not reloaded")
        XCTAssertFalse(view.isLoaderAnimating, "Loader is Animating")
        XCTAssertEqual(sut.viewState, CharactersListViewStates.loaded,
                       "after getCharacters method success viewState is not set as .loaded")
        XCTAssertEqual(sut.dataProvider.characterItemsDataProvider.count, sut.charactersList.count)
    }
    
    func test_afterSelectingFilter_genderMale_shouldShowOnlyMaleCharacters() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let characters: [RickAndMortyCharacter] = [
            .maleAliveCharacter, .maleDeadCharacter, .femaleDeadCharacter, .felameAliveCharacter
        ]
        charactersUseCase.returnedResult = .success(.getSuccessResponse(with: characters))
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        sut.didSelectedGenderFilter(type: .Male)
        XCTAssertEqual(sut.dataProvider.characterItemsDataProvider.count, sut.filteredCharacterList.count)
        XCTAssertEqual([RickAndMortyCharacter.maleAliveCharacter, RickAndMortyCharacter.maleDeadCharacter], sut.filteredCharacterList)
    }
    
    func test_afterSelectingFilter_genderMale_and_statusDead_shouldShowAppropriateResults() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let characters: [RickAndMortyCharacter] = [
            .maleAliveCharacter, .maleDeadCharacter, .femaleDeadCharacter, .felameAliveCharacter, .felameAliveCharacter, .maleAliveCharacter
        ]
        charactersUseCase.returnedResult = .success(.getSuccessResponse(with: characters))
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        sut.didSelectedGenderFilter(type: .Male)
        sut.didSelectedStatusFilter(type: .Dead)
        XCTAssertEqual(sut.dataProvider.characterItemsDataProvider.count, sut.filteredCharacterList.count,
                       "Filtered array count is not equal showed items")
        XCTAssertEqual([RickAndMortyCharacter.maleDeadCharacter], sut.filteredCharacterList,
                       "Failure in Filtering")
    }
    
    func test_afterSearchingText_shouldShowAppropiateResults() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let characters: [RickAndMortyCharacter] = [
            .maleAliveCharacter,
            .maleDeadCharacter,
            .femaleDeadCharacter,
            .characterNamedRicky2,
            .felameAliveCharacter,
            .felameAliveCharacter,
            .maleAliveCharacter,
            .characterNamedRicky1
        ]
        charactersUseCase.returnedResult = .success(.getSuccessResponse(with: characters))
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        sut.searchedText = "Ricky"
        XCTAssertEqual([RickAndMortyCharacter.characterNamedRicky2, RickAndMortyCharacter.characterNamedRicky1], 
                       sut.filteredCharacterList,
                       "Failure: wrong result after searched text")
        XCTAssertNotEqual([RickAndMortyCharacter.characterNamedRicky1, RickAndMortyCharacter.characterNamedRicky2],
                          sut.filteredCharacterList,
                          "Failure: Wrong ordering after searched text")
        sut.searchedText = ""
        XCTAssertEqual(characters,
                       sut.filteredCharacterList,
                       "Failure: After Clearing searched text, result is not correct")
    }
    
    func test_afterScrollingBottom_shouldSendNextPageRequestWith_correctPageNumber() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let characters: [RickAndMortyCharacter] = [
            .maleAliveCharacter,
            .maleDeadCharacter
        ]
        let nextUrl = "https://rickandmortyapi.com/api/character?page=2"
        charactersUseCase.returnedResult = .success(.getSuccessResponse(with: characters, nextURL: nextUrl))
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        
        let expectation2 = XCTestExpectation(description: "Scrolling Bottom and sending second page Request")
        Task { @MainActor in
            sut.getCharacters()
            expectation2.fulfill()
        }
        await fulfillment(of: [expectation2])
        XCTAssertEqual(charactersUseCase.requestModel?.page, "2", "Next Page Is Not Send Correctly")
    }
    
    func test_TestSearch_CombinedWith_Filtering() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let characters: [RickAndMortyCharacter] = [
            .getCharacteWith(name: "Jim Beam", gender: .Male, status: .Dead),
            .getCharacteWith(name: "Korkota", gender: .Genderless, status: .Alive),
            .getCharacteWith(name: "Jimsher", gender: .Male, status: .unknown),
            .getCharacteWith(name: "Jemala", gender: .unknown, status: .Alive),
            .getCharacteWith(name: "Tamila", gender: .Female, status: .Alive)
        ]
        charactersUseCase.returnedResult = .success(.getSuccessResponse(with: characters))
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        sut.searchedText = "Jim"
        sut.didSelectedGenderFilter(type: .Male)
        XCTAssertEqual([characters[0], characters[2]], sut.filteredCharacterList, "Failure: Wrong result")
        sut.didSelectedStatusFilter(type: .Alive)
        XCTAssertTrue(sut.filteredCharacterList.isEmpty, "Failure: result should be empty array")
    }
    
    func test_AfterSelectingCharacter_ShouldOpen_CharacterDetailsPage() async {
        let expectation = XCTestExpectation(description: "Characters loaded with success")
        let result: RickAndMortyCharactersResult = .successResponseWith20Items
        charactersUseCase.returnedResult = .success(result)
        Task { @MainActor in
            sut.viewDidLoad()
            expectation.fulfill()
        }
        await fulfillment(of: [expectation])
        sut.didTappedCharacter(at: 2)
        XCTAssertTrue(router.didMovedToDetailsPage)
        XCTAssertEqual(router.characterModel, result.results[2])
    }
}
