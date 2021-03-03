//
//  RecipeDetailViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import UIKit
import WebKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Instance variables
    var recipe: Recipe? = nil
    var recipeHasVideo: Bool = true
    
    let favoriteRecipeRepository = FavoriteRecipeRepository()
    let recipeNotesRepository = RecipeNotesRepository()

    // MARK: - UIElement outlets
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var nameLabel: PaddingLabel!
    @IBOutlet weak var creditsLabel: PaddingLabel!
    @IBOutlet weak var watchVideoButton: UIButton!
    @IBOutlet weak var thumbnailButton: UIButton!
    @IBOutlet weak var ingredientsLabel: PaddingLabel!
    @IBOutlet weak var ingredientsStack: UIStackView!
    @IBOutlet weak var instructionsLabel: PaddingLabel!
    @IBOutlet weak var instructionsStack: UIStackView!
    @IBOutlet weak var nutritionLabel: PaddingLabel!
    @IBOutlet weak var nutritionStack: UIStackView!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    // MARK: - OnLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            updateFavoriteButton(recipe)
            
            nameLabel.text = recipe.name
            loadCredits(recipe)
            loadThumbnail(recipe)
            loadIngredients(recipe)
            loadInstructions(recipe)
            loadNutrition(recipe)
            loadNotes(recipe)
        }
    }
    
    // MARK: - Orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        showHideWatchButtons()
    }
    
    // MARK: - View building
    private func updateFavoriteButton(_ recipe: Recipe) {
        if self.favoriteRecipeRepository.isFavorite(recipe) {
            favoriteButton.title = "Unfavorite"
        } else {
            favoriteButton.title = "Favorite"
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
    
    private func loadThumbnail(_ recipe: Recipe) {
        if let _ = recipe.original_video_url {
            thumbnailButton.downloaded(from: recipe.thumbnail_url, for: .normal)
            recipeHasVideo = true;
        } else {
            thumbnailButton.isHidden = true
            watchVideoButton.isHidden = true
            recipeHasVideo = false;
        }
    }

    private func loadIngredients(_ recipe: Recipe) {
        ingredientsStack.clear()
        
        if !recipe.ingredients.isEmpty {
            for ingredient in recipe.ingredients {
                let label = createLabel(text: " -    \(ingredient)", color: .white, fontSize: 16)
                ingredientsStack.addArrangedSubview(label)
            }
            ingredientsLabel.isHidden = false
        } else {
            ingredientsLabel.isHidden = true
        }
    }

    private func loadInstructions(_ recipe: Recipe) {
        instructionsStack.clear()
        
        if let instructions = recipe.instructions {
            if !instructions.isEmpty {
                for index in 0..<instructions.count {
                    let instruction = instructions[index]
                    if let text = instruction.display_text {
                        let label = createLabel(text: " \(index+1).    \(text)", color: .white, fontSize: 16)
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
        nutritionStack.clear()
        
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
    
    private func loadNotes(_ recipe: Recipe) {
        notesTextView.text = recipeNotesRepository.getNotes(recipe: recipe)
    }
    
    // MARK: - Actions
    @IBAction func playVideo(_ sender: Any) {
        if let recipe = recipe, let videoUrl = recipe.original_video_url {
            UIApplication.shared.open(videoUrl);
        }
    }
    @IBAction func toggleFavorite(_ sender: Any) {
        if let recipe = recipe {
            self.favoriteRecipeRepository.toggleFavorite(recipe)
            updateFavoriteButton(recipe)
        }
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if let recipe = recipe {
            recipeNotesRepository.setNotes(notes: notesTextView.text, recipe: recipe)
            
            let alert = AlertHelper().alert(title: "Saved", message: "Note has been saved succesfully!", actions: [
                UIAlertAction(title: "Ok", style: .default)
            ])
            
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - Helpers
    private func createNutritionRow(label text: String, value: Double) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal

        // create and add label
        let label = createLabel(text: text, color: .white, fontSize: 16)
        stack.addArrangedSubview(label)

        // create and add value
        let value = createLabel(text: String(value), color: .white, fontSize: 16)
        value.textAlignment = .right
        stack.addArrangedSubview(value)

        return stack
    }
    
    private func createLabel(text: String, color: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.text = text
        label.font = label.font.withSize(fontSize)
        label.textColor = color
        return label
    }
    
    private func showHideWatchButtons() {
        if (recipeHasVideo) {
            watchVideoButton.isHidden = UIDevice.current.orientation.isPortrait;
            thumbnailButton.isHidden = UIDevice.current.orientation.isLandscape;
        }
    }
}
