//
//  ImageCache.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 08.03.24.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

func downloadImage(from url: URL?, completion: @escaping ((UIImage) -> Void)) {
    guard let url else {
        completion(UIImage(named: "defaultPlaceholderImage")!)
        return
    }
    if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
        completion(imageFromCache)
        return
    }
    URLSession.shared.dataTask(with: url) {
        data, response, error in
        DispatchQueue.main.async {
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageToCache = UIImage(data: data)
            else { return }
            imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
            completion(imageToCache)
        }
        
    }.resume()
}
