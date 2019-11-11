//
//  Pokemon.swift
//  Pokedex
//
//  Created by Christy Hicks on 11/10/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    var id: Int
    var name: String
    var abilities: [AbilityDictionary]
    var sprites: Sprite
    var types: [TypeDictionary]
}

struct AbilityDictionary: Codable {
    var ability: AbilitySubdictionary
}

struct AbilitySubdictionary: Codable {
    var name: String
}

struct TypeDictionary: Codable {
    var type: TypeSubdictionary
}

struct TypeSubdictionary: Codable {
    let name: String
}

struct Sprite: Codable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
