//
//  AsrStartEvent.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

struct AsrStartEvent: Codable {
    private(set) var type = "asrStart"
    
    let learningLocale: String
    
    private(set) var metadata = [
        "deviceAudio": [
            "inputSampleRate": 16000,
        ]
    ]
}
