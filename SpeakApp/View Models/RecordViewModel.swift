//
//  RecordViewModel.swift
//  SpeakApp
//
//  Created by Jason Wells on 11/16/24.
//

import Foundation

@Observable
class RecordViewModel {
    private let client: AsrClient
    private let service: RecordService
    
    var message: String = ""
    
    // Supports future testability
    init(client: AsrClient = AsrClient.shared, service: RecordService = RecordService.shared) {
        self.client = client
        self.service = service
    }
    
    func record() {
        client.start(learningLocale: Locale.current)
        service.fetch { [weak self] events in
            //for event in events {
            //self?.client.stream(event: events.last!)
            //}
        }
    }
    
}
