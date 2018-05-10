//
//  Resource.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/10/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse : (Data) -> T?
}

extension Resource where T: Decodable {
    init(_ url: URL, parseJSON: (Data) -> T? ) {
        self.url = url
        self.parse =  { data in
            let decoder = JSONDecoder()
            let object = try? decoder.decode(T.self, from: data)
            return object
        }
    }
}
