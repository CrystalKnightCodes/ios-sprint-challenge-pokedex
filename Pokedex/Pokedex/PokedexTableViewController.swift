//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Christy Hicks on 11/10/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    // MARK: - Properties
    var apiController = APIController()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiController.pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        cell.textLabel?.text = apiController.pokemonList[indexPath.row].name

        return cell
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            apiController.pokemonList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokeSearchSegue" {
            if let searchVC = segue.destination as? PokeSearchViewController {
                searchVC.apiController = apiController
            }
            
        } else if segue.identifier == "pokeDetailSegue" {
            if let detailVC = segue.destination as? PokeSearchViewController {
                detailVC.apiController = apiController
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.pokemon = apiController.pokemonList[indexPath.row]
                }
            }
        }
    }
}
