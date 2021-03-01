//
//  FavoriteRepository.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 26/02/2021.
//

import Foundation

class FavoriteRecipeRepository {
    
    // MARK: - Instance variables
    private let key: String = "favorites"
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Public operations
    public func getFavorites() -> [Recipe] {
        if let data = UserDefaults.standard.data(forKey: self.key) {
            do {
                let favorites = try self.decoder.decode([Recipe].self, from: data)
                return favorites
            } catch {
                print("Unable to Decode Favorite (\(error))")
            }
        }
        return []
    }
    
    public func setFavorites(favorites array: [Recipe]) {
        do {
            let data = try self.encoder.encode(array)
            UserDefaults.standard.set(data, forKey: self.key)
        } catch {
            print("Unable to Encode Recipe (\(error))")
        }
    }
    
    public func toggleFavorite(_ recipe: Recipe) {
        // 1. Get all recipes
        var recipes = getFavorites()
        
        // 2. Get index of recipe from array
        let index = findRecipe(recipes: recipes, recipe: recipe)
        
        // 3. Check if favorite has been found
        //    when found      =>  remove it
        //    when not found  =>  add it
        if let index = index {
            recipes.remove(at: index)
        } else {
            recipes.append(recipe)
        }
        
        // 4. Save data
        setFavorites(favorites: recipes)
    }
    
    public func isFavorite(_ recipe: Recipe) -> Bool {
        // 1. Get all recipes
        let recipes = getFavorites()
        
        // 2. Get index of recipe from array
        let index = findRecipe(recipes: recipes, recipe: recipe)
        
        // 3. Check if favorite has been found
        return (index != nil)
    }
    
    // MARK: - Helpers
    private func findRecipe(recipes: [Recipe], recipe: Recipe) -> Int?  {
        return recipes.firstIndex { (item) -> Bool in
            return item.id == recipe.id
        }
    }
}
