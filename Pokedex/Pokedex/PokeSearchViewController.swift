//
//  PokeSearchViewController.swift
//  Pokedex
//
//  Created by Christy Hicks on 11/10/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    var pokemon: Pokemon? {
        didSet {
            getDetails()
        }
    }
    
   // var pokemonList: [Pokemon]?
    var apiController: APIController?
    
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        getDetails()
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            idLabel.isHidden = true
            typesLabel.isHidden = true
            abilitiesLabel.isHidden = true
            saveButton.isHidden = true
            return
        }
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        saveButton.isHidden = false
        
        var typesString = ""
        var abilitiesString = ""
        
        for types in pokemon.types {
            typesString += " \(types.type.name),"
        }
        
        for abilities in pokemon.abilities {
            abilitiesString += " \(abilities.ability.name),"
        }
        
        nameLabel.text = pokemon.name
        idLabel.text = "\(pokemon.id)"
        typesLabel.text = typesString
        abilitiesLabel.text = abilitiesString
    }
    
    func getDetails() {
        guard let apiController = apiController,
            let pokemonName = pokemon?.name else {
                    print("PokeSearchViewController: API Controller and pokemon name are required dependencies.")
                    return
            }
            
        apiController.fetchPokemon(name: pokemonName) { result in
                do {
                    let pokemon = try result.get()
                    DispatchQueue.main.async {
                        self.updateViews()
                    }
                    
                    apiController.fetchImage(at: pokemon.sprites.frontDefault) { result in
                        if let image = try? result.get() {
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                } catch {
                    if let error = error as? NetworkError {
                        switch error {
                        case .noAuth:
                            print("Unecessary attempt at authorization.")
                        case .badAuth:
                            print("Unecessary attempt at authorization.")
                        case .otherError:
                            print("Other error occurred, see log")
                        case .badData:
                            print("No data received, or data corrupted")
                        case .noDecode:
                            print("JSON could not be decoded")
                        }
                    }
                }
            }
        }

    
    // MARK: - Actions
    @IBAction func saveTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else { return }
        apiController?.pokemonList.append(pokemon)
        navigationController?.popViewController(animated: true)
    }
    
}

extension PokeSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        
        apiController?.fetchPokemon(name: searchTerm, completion: { (pokemon) in
            if let pokemonResult = try? pokemon.get() {
                self.pokemon = pokemonResult
                
                
                DispatchQueue.main.async {
                    self.getDetails()
                }
            }
        })
    }
}
