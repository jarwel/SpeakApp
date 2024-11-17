//
//  CourseViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import UIKit

@Observable
class CourseViewModel {
    private static let unitImage = UIImage(named: "Unit")!
    private static let dayImage = UIImage(named: "Day")!
    
    var course: Course?
    
    func fetchCourse() {
        CourseService.shared.fetch() { course in
            self.course = course
        }
    }
    
    func image(for course: Course, completion: @escaping (UIImage) -> Void) {
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
    
    func image(for unit: Unit) -> UIImage {
        return Self.unitImage
    }
    
    func image(for day: Day, completion: @escaping (UIImage) -> Void) {
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
