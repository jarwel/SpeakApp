//
//  ImageService.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import UIKit

class ImageService {
    static let shared = ImageService()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func dataForUrl(_ url: URL, _ completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                print("Image cached: \(url.absoluteString)")
                completion(image)
            }
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            var image: UIImage? = nil
            
            do {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data)
                if let image = image {
                    print("Image fetched: \(url.absoluteString)")
                    self?.cache.setObject(image, forKey: url as NSURL)
                }
            } catch {
                print("Error fetching image: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }
    }
}
