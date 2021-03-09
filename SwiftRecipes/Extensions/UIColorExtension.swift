//
//  UIColorExtension.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 24/02/2021.
//  Referenced from https://medium.com/flawless-app-stories/how-to-turn-xcode-color-assets-xcassets-into-uicolor-extension-3dc28953d4d3
//

import UIKit

@objc public extension UIColor {
    static let primary = UIColor.color(named: "PrimaryColor")
    static let darkerPrimary = UIColor.color(named: "DarkerPrimaryColor")
    static let darkestPrimary = UIColor.color(named: "DarkestPrimaryColor")
    static let accent = UIColor.color(named: "AccentColor")
    
    static let allColors: [UIColor] = [
        primary,
        darkerPrimary,
        darkestPrimary,
        accent
    ]
    
    static let allNames: [String] = [
        "PrimaryColor",
        "DarkerPrimaryColor",
        "DarkestPrimaryColor",
        "AccentColor",
    ]
    
    private static func color(named: String) -> UIColor {
        if let color = UIColor(named: named) {
            return color
        } else {
            return UIColor(red: 255, green: 255, blue: 255, alpha: 255)
        }
    }
}
