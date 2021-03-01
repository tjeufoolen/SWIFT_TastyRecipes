//
//  FavoritesListViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class FavoritesListViewController: RecipeListTableViewController {
    // MARK: - Onload
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recipes = FavoriteRecipeRepository().getFavorites()
        self.tableView.reloadData()
    }
}
