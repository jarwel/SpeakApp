//
//  RecordViewModelTests.swift
//  SpeakAppTests
//
//  Created by Jason Wells on 11/19/24.
//

import Testing

@testable import SpeakApp

struct RecordViewModelTests {
    
    @Test func should_return_translation() async throws {
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
