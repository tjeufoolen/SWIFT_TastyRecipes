//
//  RecipeListViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class RecipeListViewController: UITableViewController {

    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TastyAPI().fetchRecipes(query: "from=0&size=20&tags=under_30_minutes") { recipes in
            DispatchQueue.main.async {
                self.recipes = recipes
                self.tableView.reloadData()
            }
        }
    }
    
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

}

