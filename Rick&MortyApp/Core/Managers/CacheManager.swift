//
//  CacheManager.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 10.03.24.
//

import Foundation

actor CacheManager {
    
    var cacheDirectory: URL
    let decoder = JSONDecoder()
    
    static let shared = CacheManager()
        
    private init() {
        cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    //MARK: Episodes TODO
    
    //MARK: Characters
    func loadCharacters() -> [Int: RickAndMortyCharacter] {
        let characterUrl = cacheDirectory.appendingPathComponent("RickAndMortyCharacters")
        do {
            let data = try Data(contentsOf: characterUrl)
            let decodedData = try decoder.decode([Int: RickAndMortyCharacter].self, from: data)
            return decodedData
        } catch {
            return [:]
        }
    }
    
    func loadSingleCharacter(with id: Int) -> RickAndMortyCharacter? {
        let characterUrl = cacheDirectory.appendingPathComponent("RickAndMortyCharacters")
        do {
            let data = try Data(contentsOf: characterUrl)
            let decodedData = try decoder.decode([Int: RickAndMortyCharacter].self, from: data)
            return decodedData[id]
        } catch { return nil }
    }
    
    func saveCharacters(characters: [Int: RickAndMortyCharacter]) {
        var savedCharacters = loadCharacters()
        characters.forEach { item in
            savedCharacters.updateValue(item.value, forKey: item.key)
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(savedCharacters)
            let filePath = cacheDirectory.appendingPathComponent("RickAndMortyCharacters")
            try data.write(to: filePath)
        } catch { }
    }
}
