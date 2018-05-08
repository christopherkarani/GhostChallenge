//
//  InputTextFieldView.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit
public final class InputTextFieldView: UIView {
    
    public let title: String

    // The label of the textfield
    public lazy var tagLabel : UILabel = {
        let label = UILabel()
        let atributedString = NSAttributedString(string: " \(title) :" , attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
        label.attributedText = atributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    public var inputTextField : UITextField = {
        let inputTF = UITextField()
        inputTF.translatesAutoresizingMaskIntoConstraints = false
        inputTF.placeholder = "Enter Titile..."
        return inputTF
    }()

    private func generalSetup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var widthConstant: CGFloat
    
    
    init(_ title: String, _ widthConstant: CGFloat) {
        self.title = title
        self.widthConstant = widthConstant
        super.init(frame: .zero)
        generalSetup()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputTextFieldView: UsingProgrammabaleConstraints {
   
    internal func setupUI() {
        addSubview(tagLabel)
        addSubview(inputTextField)

        NSLayoutConstraint.activate([
            tagLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            tagLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tagLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -12),
            tagLabel.widthAnchor.constraint(equalToConstant: widthConstant),
            ])
        
        NSLayoutConstraint.activate([
            inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            inputTextField.leftAnchor.constraint(equalTo: tagLabel.rightAnchor, constant: 4),
            inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            inputTextField.heightAnchor.constraint(equalTo: heightAnchor, constant: -12)
            ])
    }
}
