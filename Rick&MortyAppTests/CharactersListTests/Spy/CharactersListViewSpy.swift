//
//  CharactersListViewSpy.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

final class CharactersListViewSpy: CharactersListView {
    
    private(set) var dataIsReloaded = false
    private(set) var filterDataIsReloaded = false
    private(set) var isLoaderAnimating = false
    
    func reloadData() {
        dataIsReloaded = true
    }
    
    func reloadFilterData() {
        filterDataIsReloaded = true
    }
    
    func startAnimating() {
        isLoaderAnimating = true
    }
    
    func stopAnimating() {
        isLoaderAnimating = false
    }
}
