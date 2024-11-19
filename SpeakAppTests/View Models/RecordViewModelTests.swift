//
//  RecordViewModelTests.swift
//  SpeakAppTests
//
//  Created by Jason Wells on 11/19/24.
//

import Testing

@testable import SpeakApp

struct RecordViewModelTests {
    
    @Test("Start Recording")
    func should_return_start_service() async throws {
        let mock = SpeakServiceMock()
        let viewModel = RecordViewModel(speakService: mock)
        viewModel.load()
        viewModel.stream()
        
        #expect(mock.isRecording)
    }
    
    @Test("Return Translation")
    func should_return_translated_text() async throws {
        let viewModel = RecordViewModel(speakService: SpeakServiceMock())

        viewModel.load()
        RecordService.shared.fetch { events in
            for event in events {
                viewModel.stream()
                
                #expect(viewModel.text == "t[\(event.chunk)]")
            }
        }
    }

}
