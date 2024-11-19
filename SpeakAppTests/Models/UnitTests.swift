//
//  UnitTests.swift
//  SpeakAppTests
//
//  Created by Jason Wells on 11/9/24.
//

import Testing

@testable import SpeakApp

struct UnitTests {
    
    @Test("Format Id")
    func should_remove_underscore_and_capitalize_id() async throws {
        let unit = Unit(id: "unit_0", days: [])
        let result = unit.formattedId
        #expect(result.contains("_") == false)
        #expect(result == result.capitalized)
    }

    @Test("Increment Id")
    func should_increments_digit() async throws {
        let digit = 0
        let unit = Unit(id: "unit_\(digit)", days: [])
        let result = unit.formattedId
        #expect(result.hasSuffix("\(digit + 1)"))
    }

}
