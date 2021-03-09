//
//  RecipeListTableViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 01/03/2021.
//

import UIKit

class RecipeListTableViewController : UITableViewController {
    // MARK: - Instance variables
    public var recipes: [Recipe] = []
    
    // MARK: - View building
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = self.recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.name
        if let ratings = recipe.user_ratings {
            let stars = String(repeating: "⭐️", count: Int(ratings.score * 5))
            cell.detailTextLabel?.text = "\(stars) \(ratings.count) Ratings"
        }
        
        return cell
    }

    // MARK: - View data transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? RecipeDetailViewController {
            if let path = self.tableView.indexPathForSelectedRow {
                detailController.recipe = recipes[path.row]
            }
        }
    }
}
