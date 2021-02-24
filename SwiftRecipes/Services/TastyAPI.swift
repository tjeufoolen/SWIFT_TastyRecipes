//
//  TastyAPI.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//

import Foundation

class TastyAPI {
    
    private let baseUrl = "https://tasty.p.rapidapi.com"
    private let decoder = JSONDecoder()
    
    public func fetchRecipes(completionHandler: @escaping ((_ recipes: [Recipe]) -> Void)) {
        if let request = buildRequest(url: "\(baseUrl)/recipes/list?from=0&size=20&tags=under_30_minutes") {
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    if let receivedData = data {
                        let recipeData = try self.decoder.decode(RecipeData.self, from: receivedData)
                        return completionHandler(recipeData.results)
                    }
                } catch let error {
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }.resume()
        }
        // if we got here it means that something went wrong with the request
        completionHandler([])
    }
    
    public func fetchRecipe(id recipeId: Int, completionHandler: @escaping ((_ recipe: Recipe?) -> Void)) {
        if let request = buildRequest(url: "\(baseUrl)/recipes/detail?id=\(recipeId)") {
            URLSession.shared.dataTask(with: request) { data, response, error in
                do {
                    if let receivedData = data {
                        let recipe = try self.decoder.decode(Recipe.self, from: receivedData)
                        return completionHandler(recipe)
                    }
                } catch let error {
                    print("Fetch failed: \(error.localizedDescription)")
                }
            }.resume()
        }
        // if we got here it means that something went wrong with the request,
        // or that the recipe with specified id does not exist
        completionHandler(nil)
    }
    
    private func buildRequest(url requestUrl: String) -> URLRequest? {
        if Environment.tasty_api_key.isEmpty {
            print("TASTY_API_KEY is empty. \nPlease fill in the tasty_api_key credentials inside Configs/Development.xcconfig.")
            return nil
        }
        
        if let url = URL(string: requestUrl) {
            var request = URLRequest(url: url)
            
            // Set headers
            request.setValue(Environment.tasty_api_key, forHTTPHeaderField: "x-rapidapi-key")
            request.setValue("tasty.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
            request.setValue("true", forHTTPHeaderField: "useQueryString")
            
            return request;
        }
        return nil;
    }
    
}
