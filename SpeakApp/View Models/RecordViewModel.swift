//
//  RecordViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

@Observable
class RecordViewModel {
    private let service: RecordService = RecordService.shared
    private let client: AsrClient = AsrClient.shared
    
    var message: String = ""
    
    func record() {
        client.start(learningLocale: Locale.current)
        service.fetch { [weak self] events in
            //for event in events {
            //self?.client.stream(event: events.last!)
            //}
        }
    }
    
}
