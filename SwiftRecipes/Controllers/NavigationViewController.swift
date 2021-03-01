//
//  NavigationViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 01/03/2021.
//

import UIKit

class NavigationViewController : UINavigationController {
    // Reset navigationController history when switching tabs
    override func viewDidDisappear(_ animated: Bool) {
        self.popToRootViewController(animated: animated)
    }
}
