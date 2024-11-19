//
//  SpeakServiceMock.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/19/24.
//

import Foundation

@testable import SpeakApp

class SpeakServiceMock: SpeakService {
    
    var delegate: SpeakServiceDelegate?
    
    var events = [AsrStreamEvent]()
    
    func start(learningLocale: Locale) {}
    func listen(callback: @escaping (String) -> Void) {}
    
    func stream(event: AsrStreamEvent) {
        delegate?.onTranslationRecieved("t[\(event.chunk)]")
    }
    
}
