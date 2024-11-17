//
//  DataService.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private let cache = NSCache<NSURL, NSData>()
    
    private init() {}
    
    func dataForUrl(_ url: URL, _ completion: @escaping (Data?) -> Void) {
        if let data = cache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                print("Image cached: \(url.absoluteString)")
                completion(data as Data)
            }
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                self?.cache.setObject(data as NSData, forKey: url as NSURL)
                DispatchQueue.main.async {
                    print("Image fetched: \(url.absoluteString)")
                    completion(data)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
            
        }
    }
}
