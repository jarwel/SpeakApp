//
//  RecordService.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/17/24.
//

import Foundation

class RecordService {
    static let shared = RecordService()
    
    private static let filePath = Bundle.main.path(forResource: "asr-stream-audio-chunks", ofType: "json")!
    
    private let decoder = JSONDecoder()
    
    private init() {}
    
    // Using a completion handler in case it needs to move to a background thread
    func fetch(_ completion: @escaping ([AsrStreamEvent]) -> Void) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: Self.filePath))
            let events = try decoder.decode([AsrStreamEvent].self, from: data)
            completion(events)
        } catch {
            print("Decoder error: \(error.localizedDescription)")
            completion([])
        }
    }
}
