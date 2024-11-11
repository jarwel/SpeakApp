//
//  CourseViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import UIKit

class CourseViewModel {
    var course: Course?
    
    private static let defaultImage = UIImage(named: "BrokenLink")!
    
    func fetch() {
        do {
            let decoder = JSONDecoder()
            let filePath = Bundle.main.path(forResource: "course", ofType: "json")!
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            course = try decoder.decode(Course.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func imageForUrl(_ thumbnailImageUrl: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: thumbnailImageUrl) else {
            completion(Self.defaultImage)
            return
        }
        
        DataService.shared.dataForUrl(url) { data in
            guard let data = data, let image = UIImage(data: data) else {
                completion(Self.defaultImage)
                return
            }
            
            completion(image)
        }
    }
}
