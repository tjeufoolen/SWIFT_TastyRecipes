//
//  RecipeDetailViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var ingredientsStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            nameLabel.text = recipe.name
            loadCredits(recipe)
            loadIngredients(recipe)
        }
    }
    
    private func loadCredits(_ recipe: Recipe) {
        var str: String = ""
        if let creators = recipe.credits, creators.count > 0 {
            str = "by "
            for index in 0..<creators.count {
                if let name = creators[index].name {
                    if index != 0 {
                        str.append(", ")
                    }
                    str.append(name)
                }
            }
        }
        creditsLabel.text = str
    }
    
    private func loadIngredients(_ recipe: Recipe) {
        for ingredient in recipe.ingredients {
            let label = UILabel()
//            label.lineBreakMode = NSLineBreakMode.byCharWrapping
//            label.numberOfLines = 3
            label.text = " -    \(ingredient)"
            label.font = label.font.withSize(16)
            label.textColor = UIColor.white
            ingredientsStack.addArrangedSubview(label)
        }
    }
}
