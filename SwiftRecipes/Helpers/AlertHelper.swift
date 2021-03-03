//
//  AlertHelper.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 03/03/2021.
//

import UIKit

class AlertHelper {
    public func alert(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
}
