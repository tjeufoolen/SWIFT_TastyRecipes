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
    
    // MARK: - Fetch methods
    public func fetchRecipes(query: String, completionHandler: @escaping ((_ recipes: [Recipe]) -> Void)) {
        if let request = buildRequest(url: "\(baseUrl)/recipes/list?\(query)") {
            executeRequest(request) { data in
                do {
                    let recipeData = try self.decoder.decode(RecipeData.self, from: data)
                    return completionHandler(recipeData.results)
                } catch let error {
                    print("Error occured while decoding request data: \(error.localizedDescription)")
                }
            }
        }
        // if we got here it means that something went wrong with the request
        completionHandler([])
    }
    
    public func fetchSingleRecipe(id recipeId: Int, completionHandler: @escaping ((_ recipe: Recipe?) -> Void)) {
        if let request = buildRequest(url: "\(baseUrl)/recipes/detail?id=\(recipeId)") {
            executeRequest(request) { data in
                do {
                    let recipe = try self.decoder.decode(Recipe.self, from: data)
                    return completionHandler(recipe)
                } catch let error {
                    print("Error occured while decoding request data: \(error.localizedDescription)")
                }
            }
        }
        // if we got here it means that something went wrong with the request,
        // or that the recipe with specified id does not exist
        completionHandler(nil)
    }
    
    // MARK: - Helpers
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
    
    private func executeRequest(_ request: URLRequest, completionHandler: @escaping ((_ data: Data) -> Void)) {
        URLSession.shared.dataTask(with: request) { data, response, error in
           if let receivedData = data {
                completionHandler(receivedData)
            }
        }.resume()
    }
}
