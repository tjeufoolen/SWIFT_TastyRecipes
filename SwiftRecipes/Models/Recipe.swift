//
//  Recipe.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import Foundation

struct RecipeData : Codable {
    var results: [Recipe]
}

struct Recipe : Codable {
    var name: String
    var description: String?
    var thumbnail_url: URL
    var video_url: URL?
    
    var credits: [Creator]?
    
    var sections: [IngredientSection]?
    var ingredients: [String] {
        get {
            var items: [String] = []
            if let sections = sections {
                for section in sections {
                    if let components = section.components {
                        for component in components {
                            if let text = component.raw_text {
                                items.append(text)
                            }
                        }
                    }
                }
            }
            return items
        }
    }
    
    var num_servings: Int?
    
    var tips_and_ratings_enabled: Bool?
    var user_ratings: UserRating?
    
    var prep_time_minutes: Int?
    var cook_time_minutes: Int?
    var total_time_minutes: Int?
    
    var nutrition: Nutrition?
}

struct Creator : Codable {
    var name: String?
    var type: String?
}

struct IngredientSection: Codable {
    var name: String?
    var components: [IngredientComponent]?
}

struct IngredientComponent: Codable {
    var raw_text: String?
}

struct UserRating : Codable {
    var count_positive: Int
    var count_negative: Int
    var count: Int {
        get {
            return count_positive + count_negative
        }
    }
    var score: Double
}

struct Nutrition : Codable {
    var fat: Double?
    var protein: Double?
    var sugar: Double?
    var fiber: Double?
    var calories: Double?
    var carbohydrates: Double?
}
