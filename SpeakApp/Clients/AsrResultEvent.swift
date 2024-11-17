//
//  AsrResultEvent.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

struct AsrResultEvent: Codable {
    private(set) var type = "asrResult"
    
    let text: String
    let isFinal: Bool
}
