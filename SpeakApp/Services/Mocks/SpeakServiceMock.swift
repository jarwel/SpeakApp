//
//  SpeakServiceMock.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/19/24.
//

import Foundation

class SpeakServiceMock: SpeakService {
    
    var delegate: SpeakServiceDelegate?
    
    var events = [AsrStreamEvent]()
    var isRecording = false
    
    func start(learningLocale: Locale) {
        isRecording = true
    }
    
    func listen(callback: @escaping (String) -> Void) {}
    
    func stream(event: AsrStreamEvent) {
        delegate?.onTranslationRecieved("t[\(event.chunk)]")
    }
    
}
