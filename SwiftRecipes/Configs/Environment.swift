//
//  Environment.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//  Referenced from https://thoughtbot.com/blog/let-s-setup-your-ios-environments
//

import Foundation

public enum Environment {
  // MARK: - Keys
  enum Keys {
    enum Plist {
      static let tasty_api_key = "TASTY_API_KEY"
    }
  }

  // MARK: - Plist
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  // MARK: - Plist values
  static let tasty_api_key: String = {
    guard let tasty_api_key = Environment.infoDictionary[Keys.Plist.tasty_api_key] as? String else {
      fatalError("API Key not set in plist for this environment")
    }
    return tasty_api_key
  }()
}
