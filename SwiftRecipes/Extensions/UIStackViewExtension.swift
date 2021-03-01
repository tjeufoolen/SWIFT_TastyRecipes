//
//  UIStackViewExtension.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 26/02/2021.
//  Referenced from https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
//

import UIKit

extension UIStackView {
    func clear() {
        arrangedSubviews.forEach() { view in
            view.removeFromSuperview()
        }
    }
}
