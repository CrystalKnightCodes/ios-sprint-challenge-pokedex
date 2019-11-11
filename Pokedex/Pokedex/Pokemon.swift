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
    var abilities: [Ability]
    var sprites: Sprite
    var types: [Type]
}

struct Ability: Codable {
    var name: String
}

struct Type: Codable {
    var name: String
}

struct Sprite: Codable {
    var frontDefault: String
}
