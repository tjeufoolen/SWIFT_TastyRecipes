//
//  RecipeDetailViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? = nil

    @IBOutlet weak var nameLabel: PaddingLabel!
    @IBOutlet weak var creditsLabel: PaddingLabel!
    @IBOutlet weak var ingredientsLabel: PaddingLabel!
    @IBOutlet weak var ingredientsStack: UIStackView!
    @IBOutlet weak var instructionsLabel: PaddingLabel!
    @IBOutlet weak var instructionsStack: UIStackView!
    @IBOutlet weak var nutritionLabel: PaddingLabel!
    @IBOutlet weak var nutritionStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            nameLabel.text = recipe.name
            loadCredits(recipe)
            loadIngredients(recipe)
            loadInstructions(recipe)
            loadNutrition(recipe)
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
        if recipe.ingredients.count > 0 {
            for ingredient in recipe.ingredients {
                let label = createLabel(text: " -    \(ingredient)", color: .white, fontSize: 16, lines: 3)
                ingredientsStack.addArrangedSubview(label)
            }
            ingredientsLabel.isHidden = false
        } else {
            ingredientsLabel.isHidden = true
        }
    }

    private func loadInstructions(_ recipe: Recipe) {
        if let instructions = recipe.instructions {
            if instructions.count > 0 {
                for index in 0..<instructions.count {
                    let instruction = instructions[index]
                    if let text = instruction.display_text {
                        let label = createLabel(text: " \(index+1).    \(text)", color: .white, fontSize: 16, lines: 10)
                        instructionsStack.addArrangedSubview(label)
                    }
                }
                instructionsLabel.isHidden = false
            } else {
                instructionsLabel.isHidden = true
            }
        }
    }

    private func loadNutrition(_ recipe: Recipe) {
        if let nutrition = recipe.nutrition {
            var itemsShown: Int = 0
            
            if let calories = nutrition.calories {
                let row = createNutritionRow(label: "calories", value: calories)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            if let sugar = nutrition.sugar {
                let row = createNutritionRow(label: "sugar", value: sugar)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            if let carbohydrates = nutrition.carbohydrates {
                let row = createNutritionRow(label: "carbohydrates", value: carbohydrates)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            if let fiber = nutrition.fiber {
                let row = createNutritionRow(label: "fiber", value: fiber)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            if let protein = nutrition.protein {
                let row = createNutritionRow(label: "protein", value: protein)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            if let fat = nutrition.fat {
                let row = createNutritionRow(label: "fat", value: fat)
                nutritionStack.addArrangedSubview(row)
                itemsShown+=1
            }
            
            nutritionLabel.isHidden = (itemsShown == 0)
        }
    }

    private func createNutritionRow(label text: String, value: Double) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal

        // create and add label
        let label = createLabel(text: text, color: .white, fontSize: 16, lines: 1)
        stack.addArrangedSubview(label)

        // create and add value
        let value = createLabel(text: String(value), color: .white, fontSize: 16, lines: 1)
        value.textAlignment = .right
        stack.addArrangedSubview(value)

        return stack
    }

    private func createLabel(text: String, color: UIColor, fontSize: CGFloat, lines: Int) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = lines
        label.text = text
        label.font = label.font.withSize(fontSize)
        label.textColor = color
        return label
    }
}
