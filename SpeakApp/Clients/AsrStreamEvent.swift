//
//  AsrStreamEvent.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

struct AsrStreamEvent: Codable {
    private(set) var type = "asrStream"
    
    let chunk: String
    let isFinal: Bool
}
