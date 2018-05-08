//
//  InputFormView.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

protocol InputFormViewDelegate {
    func didTapSaveButton(forView view: InputFormView)
}


// This View handles Input from the User
class InputFormView: UIView, UsingProgrammabaleConstraints {
    
    var delegate: InputFormViewDelegate?
    
    let dreamTextField = InputTextFieldView("Dream Title", 105)
    let dateField : InputTextFieldView = {
        let inputTextField = InputTextFieldView("Date", 50)
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        inputTextField.inputTextField.text = formatter.string(from: Date())
        return inputTextField
    }()
    
    let tagsField : InputTextFieldView = {
        let inputTextField = InputTextFieldView("Tags", 50)
        inputTextField.inputTextField.placeholder = "Enter tags seperated by ','"
        return inputTextField
    }()
    
    lazy var uiComponentStackView : UIStackView = {
        let arrangedSubviews : [UIView] = [ dreamTextField, dateField, tagsField]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(white: 0.85, alpha: 1)
        return textView
    }()
    
    var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSAttributedString(string: "Description", attributes: [.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(76, 209, 55)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSaveButton() {
        print("save button tapped from within input View")
        delegate?.didTapSaveButton(forView: self)
        dreamTextField.inputTextField.text = nil
        dateField.inputTextField.text = nil
        tagsField.inputTextField.text = nil
        descriptionTextView.text = nil
    }
    
    func setupInputTextFieldUI() {
        uiComponentStackView.backgroundColor = .orange
        addSubview(uiComponentStackView)
        NSLayoutConstraint.activate([
            uiComponentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            uiComponentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            uiComponentStackView.widthAnchor.constraint(equalTo: widthAnchor, constant: -12),
            uiComponentStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3)
        ])
    }
    
    func setupDescriptionTextInput() {
        addSubview(descriptionTitleLabel)
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: uiComponentStackView.bottomAnchor, constant: 8),
            descriptionTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            descriptionTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -12),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, constant: -12),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 180)
            ])
    }
    
    func setupSaveButton() {
        addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            saveButton.centerXAnchor.constraint(equalTo: descriptionTextView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 140),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    
    // Standarnd UI Setup for this view
    func generalSetup() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func setupUI() {
        setupInputTextFieldUI()
        setupDescriptionTextInput()
        setupSaveButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generalSetup()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
