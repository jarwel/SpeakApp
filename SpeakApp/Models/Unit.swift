//
//  Unit.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import Foundation

struct Unit: Codable {
    let id: String
    let days: [Day]
    
    var formattedId: String {
        return "Unit \(id.dropFirst(5))"
    }
}
