//
//  CourseViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import Foundation

class CourseViewModel {
    var course: Course?
    
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
}
