//
//  Dream.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation

struct Dream {
    var title: String
    var dateString: String
    var tags: [String]
    var description: String
}

// A way to see if two dreams are the same
extension Dream: Equatable {
    static func ==(_ lhs: Dream, _ rhs: Dream) -> Bool {
        let titleCheck = lhs.title == rhs.title
        let dateCheck = lhs.dateString == rhs.dateString
        return titleCheck && dateCheck
    }
}

