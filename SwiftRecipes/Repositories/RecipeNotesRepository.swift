//
//  RecipeNotesRepository.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 03/03/2021.
//

import Foundation

class RecipeNotesRepository {
    
    // MARK: - Public operations
    public func getNotes(recipe: Recipe) -> String {
        do {
            let name = recipeNotesFileName(recipe)
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectory.appendingPathComponent(name)
            
            return try String(contentsOf: fileUrl, encoding: String.Encoding.unicode)
        } catch {
            return ""
        }
    }
    
    public func setNotes(notes: String, recipe: Recipe) {
        do {
            let name = recipeNotesFileName(recipe)
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectory.appendingPathComponent(name)

            let noteContents = notes
            try noteContents.write(to: fileUrl, atomically: true, encoding: .unicode)
        } catch {}
    }
    
    // MARK: - Helpers
    private func recipeNotesFileName(_ recipe: Recipe) -> String {
        return "recipe-\(recipe.id).txt"
    }
}

