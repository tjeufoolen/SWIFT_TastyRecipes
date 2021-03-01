//
//  RecipeListViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class RecipeListViewController: RecipeListTableViewController {
    // MARK: - Onload
    override func viewDidLoad() {
        TastyAPI().fetchRecipes(query: "from=0&size=20&tags=under_30_minutes") { recipes in
            DispatchQueue.main.async {
                self.recipes = recipes
                self.tableView.reloadData()
            }
        }
    }
}

