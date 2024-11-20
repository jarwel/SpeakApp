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
    
    var text: String?
    var hasEvents = false
    var isRecording = false
    
    // Supports future testability
    init(speakService: SpeakService = AsrClient.shared, recordService: RecordService = RecordService.shared) {
        self.recordService = recordService
        self.speakService = speakService
        self.speakService.delegate = self
    }
    
    func load() {
        recordService.fetch { [weak self] events in
            self?.events = events
            self?.text = nil
            self?.hasEvents = true
            self?.speakService.start(learningLocale: Locale.current)
        }
    }
    
    func stream() {
        text = nil
        isRecording = true
        while events.isEmpty == false {
            let event = events.removeFirst()
            speakService.stream(event: event)
        }
    }
    
}

extension RecordViewModel: SpeakServiceDelegate {
    
    func onTranslationRecieved(_ text: String, isFinal: Bool) {
        if let current = self.text {
            self.text = [current, text].joined(separator: " ")
        } else {
            self.text = text
        }
        if isFinal {
            self.isRecording = false
        }
    }
}

