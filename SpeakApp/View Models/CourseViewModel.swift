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
    
    private let courseService: CourseService
    private let imageService: ImageService
    
    var course: Course?
    
    // Supports future testability
    init(courseService: CourseService = CourseService.shared, imageService: ImageService = ImageService.shared) {
        self.courseService = courseService
        self.imageService = imageService
    }
    
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
        
        ImageService.shared.dataForUrl(url) { image in
            if let image = image {
                completion(image)
            } else {
                completion(Self.dayImage)
            }
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
        
        ImageService.shared.dataForUrl(url) { image in
            if let image = image {
                completion(image)
            } else {
                completion(Self.dayImage)
            }
        }
    }
}
