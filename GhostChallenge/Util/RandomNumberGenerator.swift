//
//  RandomNumberGenerator.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/9/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation
import GameplayKit

struct RandomNumberGenerator {
    fileprivate let source = GKRandomSource.sharedRandom()
    
    // return an absolute random Number
    public func getRandomNumber(withUpperBound bound: Int) -> Double {
        let randomSource = source.nextInt(upperBound: bound)
        return Double(randomSource)
    }
}
