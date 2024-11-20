//
//  SpeakServiceMock.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/19/24.
//

import Foundation

class SpeakServiceMock: SpeakService {
    var delegate: SpeakServiceDelegate?
    var isStarted = false

    private var dispatchTime = DispatchTime.now()
    
    func start(learningLocale: Locale) {
        dispatchTime = DispatchTime.now()
        isStarted = true
    }
    
    func stream(event: AsrStreamEvent) {
        // Add random delay for testing and assuming order is maintained
        dispatchTime = dispatchTime + Double(Int.random(in: 0...1))
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [weak self] in
            self?.delegate?.onTranslationRecieved("t[word]", isFinal: event.isFinal)
        }
    }
    
}
