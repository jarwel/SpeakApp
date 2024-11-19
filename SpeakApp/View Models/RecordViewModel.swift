//
//  RecordViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

@Observable
class RecordViewModel {
    private let recordService: RecordService
    
    private var speakService: SpeakService
    private var events = [AsrStreamEvent]()
    
    var text = ""
    
    // Supports future testability
    init(speakService: SpeakService = AsrClient.shared, recordService: RecordService = RecordService.shared) {
        self.recordService = recordService
        self.speakService = speakService
        self.speakService.delegate = self
    }
    
    func load() {
        recordService.fetch { [weak self] events in
            self?.events = events.reversed()
        }
    }
    
    func stream() {
        guard let event = events.popLast() else {
            print("No more events to stream")
            return
        }
        
        speakService.stream(event: event)
    }
    
}

extension RecordViewModel: SpeakServiceDelegate {
    
    func onTranslationRecieved(_ text: String) {
        self.text = text
    }
}

