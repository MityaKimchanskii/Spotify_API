//
//  Character.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//
import Foundation


struct Character: Codable, Hashable {
    let id: Int?
    let name: String
    let imageUrl: String?
    let gender: String?
    let occupation: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image"
        case gender, occupation
    }
}

//"id": 1,
//"name": "\"Dottie Minerva\"",
//"relatives": [],
//"wikiUrl": "https://bobs-burgers.fandom.com/wiki/%22Dottie_Minerva%22",
//"image": "https://bobsburgers-api.herokuapp.com/images/characters/1.jpg",
//"gender": "Female",
//"hair": "Blonde",
//"occupation": "Student at Wagstaff School",
//"allOccupations": [
//  "Student at Wagstaff School"
//],
//"firstEpisode": "\"The Kids Run the Restaurant\"",
//"voicedBy": "Wendy Molyneux",
//"url": "https://bobsburgers-api.herokuapp.com/characters/1"
