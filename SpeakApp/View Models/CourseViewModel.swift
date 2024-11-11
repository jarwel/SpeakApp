//
//  CourseViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import UIKit

class CourseViewModel {
    var course: Course?
    
    private static let unitImage = UIImage(named: "Unit")!
    private static let dayImage = UIImage(named: "Day")!
    
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
    
    func imageForCourse(_ course: Course, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: course.info.thumbnailImageUrl) else {
            completion(Self.dayImage)
            return
        }
        
        DataService.shared.dataForUrl(url) { data in
            guard let data = data, let image = UIImage(data: data) else {
                completion(Self.dayImage)
                return
            }
            
            completion(image)
        }
    }
    
    func imageForUnit() -> UIImage {
        return Self.unitImage
    }
    
    func imageForDay(_ day: Day, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: day.thumbnailImageUrl) else {
            completion(Self.dayImage)
            return
        }
        
        DataService.shared.dataForUrl(url) { data in
            guard let data = data, let image = UIImage(data: data) else {
                completion(Self.dayImage)
                return
            }
            
            completion(image)
        }
    }
}
