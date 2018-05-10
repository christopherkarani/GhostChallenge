//
//  DreamData.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation

typealias DreamCodable = DreamDatabseDecodable & DreamDatabaseEncodAble

//Protocol to write Information From Dream Database Singleton, This wrapper makes for easy to scale code
protocol DreamDatabaseEncodAble {
    func write(toDatabase data: [Dream])
    func add(toDatabase data: Dream)
}

extension DreamDatabaseEncodAble {
    func write(toDatabase data: [Dream]) {
        DreamDatabase.DatabaseData.data = data
    }
    
    func add(toDatabase data: Dream)  {
        DreamDatabase.DatabaseData.data.append(data)
    }
}

//Protocol to read Information From Dream Database Singleton, This wrapper makes for easy to scale code
protocol DreamDatabseDecodable {
    func read() -> [Dream]
    func find(_ dreamTitle: String) -> Dream?
}

extension DreamDatabseDecodable {
    // simply returns a copy of the dream objects
    func read() -> [Dream] {
        return DreamDatabase.DatabaseData.data
    }
    
    func find(_ dreamTitle: String) -> Dream? {
        _ = DreamDatabase.DatabaseData.data.map { dream -> (Dream?) in
            if dreamTitle == dream.title {
                return dream
            }
            return nil
        }
        return nil
    }
}

//Wrapper Around Dream Database Class, making this more testable
extension DreamDatabaseEncodAble {
    func write(toData data: Dream) {
        DreamDatabase.DatabaseData.data.append(data)
    }
}
// simple wrapper around dream collection
struct DreamData : DreamCodable {
    var data = [Dream]()
}

//where we store our dream entries,
//want this to have reference semantics around the Database Data, which is only a struct
class DreamDatabase{
    static let database = DreamDatabase()
    static var DatabaseData = DreamData()
}
