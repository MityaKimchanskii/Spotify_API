//
//  BobsBurgersFullCycleAppTests.swift
//  BobsBurgersFullCycleAppTests
//
//  Created by Mitya Kim on 12/13/24.
//

import XCTest
@testable import BobsBurgersFullCycleApp


final class CharacterDataTest: XCTestCase {
    func testCanParseCharacter() throws {
        let json = """
                {
                    "name": "Bob",
                    "gender": "Male",
                    "occupation": "Student",
                    "image": "https://www.google.com"
                }
                """
        
        let jsonData = json.data(using: .utf8)!
        let characterData = try JSONDecoder().decode(Character.self, from: jsonData)
        
        XCTAssertEqual("Bob", characterData.name)
        XCTAssertEqual("Male", characterData.gender)
        XCTAssertEqual("Student", characterData.occupation)
        XCTAssertEqual("https://www.google.com", characterData.imageURL)
    }
    
    func testCanParseCharactersViaJSONFile() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "Data", ofType: "json") else {
            fatalError("JSON file not found!")
        }
        
        print("\n\n\(pathString)\n\n")
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let characterData = try JSONDecoder().decode([Character].self, from: jsonData)
        
        XCTAssertEqual("\"Dottie Minerva\"", characterData.first?.name)
        XCTAssertEqual("Female", characterData.first?.gender)
        XCTAssertEqual("Student at Wagstaff School", characterData.first?.occupation)
        XCTAssertEqual("https://bobsburgers-api.herokuapp.com/images/characters/1.jpg", characterData.first?.imageURL)
        
    }
}
