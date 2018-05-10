//
//  DateFactory.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/9/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation

// gives me an easy to use date string
struct DateFmt {
    
    let dateString: String
    
    init(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateString = formatter.string(from: date)
    }
}
