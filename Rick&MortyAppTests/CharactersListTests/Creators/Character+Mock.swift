//
//  Character+Mock.swift
//  Rick&MortyAppTests
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

@testable import Rick_MortyApp

extension RickAndMortyCharacter: Equatable {
    static let maleAliveCharacter: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Dimitri",
              status: .Alive,
              species: "",
              type: "",
              gender: .Male,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static let maleDeadCharacter: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Korkota",
              status: .Dead,
              species: "",
              type: "",
              gender: .Male,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static let felameAliveCharacter: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Tamila",
              status: .Alive,
              species: "",
              type: "",
              gender: .Female,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static let femaleDeadCharacter: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Naziko",
              status: .Dead,
              species: "",
              type: "",
              gender: .Female,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static let characterNamedRicky1: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Ricky Tutashkhia",
              status: .Dead,
              species: "",
              type: "",
              gender: .Male,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static let characterNamedRicky2: RickAndMortyCharacter = {
        .init(id: 0,
              name: "Ricky Pirveli",
              status: .Dead,
              species: "",
              type: "",
              gender: .Male,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }()
    
    static func getCharacteWith(name: String = "",
                                gender: RickAndMortyCharacterGenderType,
                                status: RickAndMortyCharacterStatusType) -> RickAndMortyCharacter {
        .init(id: 0,
              name: name,
              status: status,
              species: "",
              type: "",
              gender: gender,
              origin: .init(name: "", url: nil),
              location: .init(name: "", url: nil),
              image: "",
              episode: [],
              url: nil,
              created: "")
    }
    
    public static func == (lhs: RickAndMortyCharacter, rhs: RickAndMortyCharacter) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type && lhs.status == rhs.status && lhs.gender == rhs.gender
    }
}
