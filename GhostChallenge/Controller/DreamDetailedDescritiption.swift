//
//  DreamDetailedDescritiption.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

class DreamDetailedDescrition: UIViewController {
    
    internal func setupUI() {
        
        let inputFormView = InputFormView()
        view.addSubview(inputFormView)
        inputFormView.layer.cornerRadius = 5
        inputFormView.layer.borderWidth = 2
        inputFormView.layer.borderColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            inputFormView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputFormView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            inputFormView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            inputFormView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -150)
            ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
