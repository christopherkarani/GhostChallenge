//
//  MainTableViewDataSource.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

class MainTableViewDataSource: NSObject {
    
    let webService = WebService()
    var dateMachines = [DateFmt]()
    var filteredDreams = [Dream]()
    var randomDates = [Date]()
    var searchController: UISearchController!
    
    var dreams : [Dream] {
        return DreamDatabase.DatabaseData.read()
    }

    fileprivate func setupDates() {
        for _ in 0...13 {
            let randomNumber = RandomNumberGenerator().getRandomNumber(withUpperBound: 100)
            let date = Date(timeIntervalSince1970: randomNumber)
            let datefmt = DateFmt(date: Date())
            dateMachines.append(datefmt)
            randomDates.append(date)
        }
    }
    
    override init() {
        super.init()
        setupDates()
        getData()
    }
}

extension MainTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredDreams.count
        } else {
            return dreams.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dream: Dream
        if searchController.isActive {
            dream = filteredDreams[indexPath.row]
        } else {
            dream = dreams[indexPath.row]
        }
        let dreamCell = tableView.dequeueReusableCell(withIdentifier: MainViewController.cellIdentifier(), for: indexPath) as! TableViewCustomCell
        dreamCell.dream = dream
        return dreamCell
    }
}

// Data Retrival
extension MainTableViewDataSource {
    func getData() {
        webService.load(resource: JSONPlaceholder.all) { [weak self] (posts) in
            guard let placeholder = posts else { return }
            _ = self?.convertPlaceholderToDreams(withPosts: placeholder)
            NotificationCenter.default.post(name: .dataRetrieved, object: nil)
        }
    }
    
    func convertPlaceholderToDreams(withPosts placeholders: [JSONPlaceholder]) -> [Dream] {
        return placeholders.map { placeholder in
            let randomNumber = RandomNumberGenerator().getRandomNumber(withUpperBound: 1)
            let dateMachine = dateMachines[Int(randomNumber)]
            let dream = Dream(title: placeholder.title, dateString: dateMachine.dateString, tags: ["happy, funny, sad, awesome"], description: placeholder.body)
            DreamDatabase.DatabaseData.write(toData: dream)
            return dream
        }
    }
}
