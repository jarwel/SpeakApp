//
//  AsrMetadata.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

struct AsrMetadataEvent: Codable {
    private(set) var type = "asrMetadata"
    
    let id: String
    let recordingId: String
}
