//
//  JSONPlaceholder.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/10/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation



// simple json placeholder object
struct JSONPlaceholder {
    static let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
    
    let userID : Int
    let id : Int
    let title : String
    let body : String
    
    enum Keys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

extension JSONPlaceholder : Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        userID = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        body = try container.decode(String.self, forKey: .body)
    }
}

extension JSONPlaceholder {
    static let all = Resource<[JSONPlaceholder]>(JSONPlaceholder.url!) { (data) -> [JSONPlaceholder]? in
        let posts = try? JSONDecoder().decode([JSONPlaceholder].self, from: data)
        return posts
    }
}
