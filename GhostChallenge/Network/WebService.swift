//
//  NetworkingFacility.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/9/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import Foundation

final class WebService {
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> () ) {
        URLSession.shared.dataTask(with: resource.url) { (recivedData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = recivedData  else { return completion(nil) }
            completion(resource.parse(data))
        }.resume()
    }
}
