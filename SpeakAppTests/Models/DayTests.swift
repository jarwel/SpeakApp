//
//  DayTests.swift
//  SpeakAppTests
//
//  Created by Jason Wells on 11/18/24.
//

import Testing

@testable import SpeakApp

struct DayTests {
    
    @Test("Format Id")
    func should_strip_to_digits() async throws {
        let day = Day(id: "day_0", title: "", subtitle: "", thumbnailImageUrl: "")
        let result = day.formattedId
        #expect(result.isEmpty == false)
        #expect(result.allSatisfy { $0.isNumber })
    }

    @Test("Pad Id")
    func should_pad_to_two_digits() async throws {
        let digit = 1
        let day = Day(id: "day_\(digit)", title: "", subtitle: "", thumbnailImageUrl: "")
        let result = day.formattedId
        #expect(result.count == 2)
        #expect(result.hasPrefix("0"))
        #expect(result.hasSuffix("\(digit)"))
    }

}
