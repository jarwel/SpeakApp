//
//  SpeakService.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/19/24.
//

import Foundation

protocol SpeakServiceDelegate {
    func onTranslationRecieved(_ text: String)
}


protocol SpeakService {
    var delegate: SpeakServiceDelegate? { get set }
    
    func start(learningLocale: Locale)
    func stream(event: AsrStreamEvent)
    func listen(callback: @escaping (String) -> Void)
}
