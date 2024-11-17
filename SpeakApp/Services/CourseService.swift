//
//  CourseService.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

class CourseService {
    static let shared = CourseService()
    
    private static let filePath = Bundle.main.path(forResource: "course", ofType: "json")!
    
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func fetch(_ completion: @escaping (Course?) -> Void) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Self.filePath))
            let course = try decoder.decode(Course.self, from: data)
            completion(course)
        } catch {
            print("Decoder error: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
