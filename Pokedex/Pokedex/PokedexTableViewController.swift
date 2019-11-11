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
    var pokemonList: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var apiController = APIController()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        cell.textLabel?.text = pokemonList[indexPath.row].name

        return cell
    }
  



    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
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
                    detailVC.pokemon = pokemonList[indexPath.row]
                }
            }
        }
    }
}
