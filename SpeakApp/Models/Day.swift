//
//  Day.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/11/24.
//

import Foundation

struct Day: Codable {
    let id: String
    let title: String
    let subtitle: String
    let thumbnailImageUrl:  String
    
    var formattedId: String {
        return String(format: "%02d", Int(id.dropFirst(4)) ?? 0)
    }
}
