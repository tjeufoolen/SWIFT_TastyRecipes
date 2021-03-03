//
//  CreditsViewController.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 03/03/2021.
//

import UIKit

class CreditsViewController: UIViewController {
    // MARK: - Actions
    @IBAction func openGithub(_ sender: Any) {
        openUrl("https://github.com/tjeufoolen")
    }
    
    @IBAction func openTwitter(_ sender: Any) {
        openUrl("https://twitter.com/tjeufoolen")
    }
    
    // MARK: - Helpers
    private func openUrl(_ url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url);
        }
    }
}
