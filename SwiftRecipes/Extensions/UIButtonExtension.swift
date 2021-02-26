//
//  UIImageViewExtension.swift
//  SwiftRecipes
//
//  Created by Tjeu Foolen on 26/02/2021.
//  Referenced from https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
//

import UIKit

extension UIButton {
    func downloaded(from url: URL, for state: UIControl.State, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.setBackgroundImage(image, for: state)
            }
        }.resume()
    }
    
    func downloaded(from link: String, for state: UIControl.State, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, for: state, contentMode: mode)
    }
}
