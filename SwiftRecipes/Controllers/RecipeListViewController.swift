//
//  RecipeListViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class RecipeListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        TastyAPI().fetchRecipes() { recipes in
//            print(recipes)
//        }
        
        TastyAPI().fetchRecipe(id: 7109) { recipe in
            if let recipe = recipe {
                print(recipe)
            }
        }
    }

}

