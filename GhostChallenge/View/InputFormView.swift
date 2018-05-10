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
        let dateMachine = DateFmt(date: Date())
        inputTextField.inputTextField.text = dateMachine.dateString
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
        
        // adding a seperatorLine for UX purposes
        setupSeperators()
    }
    
    fileprivate func setupSeperators() {
        // adding a seperatorLine for UX purposes
        let dreamTitleLineSeparator = UIView()
        dreamTitleLineSeparator.backgroundColor = .lightGray
        dreamTitleLineSeparator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dreamTitleLineSeparator)
        NSLayoutConstraint.activate([
            dreamTitleLineSeparator.topAnchor.constraint(equalTo: dreamTextField.bottomAnchor, constant: -20),
            dreamTitleLineSeparator.leftAnchor.constraint(equalTo: dreamTextField.leftAnchor),
            dreamTitleLineSeparator.widthAnchor.constraint(equalTo: dreamTextField.widthAnchor),
            dreamTitleLineSeparator.heightAnchor.constraint(equalToConstant: 0.7)
            ])
        
        let dateTitleSeperatorLine = UIView()
        dateTitleSeperatorLine.backgroundColor = .lightGray
        dateTitleSeperatorLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateTitleSeperatorLine)
        NSLayoutConstraint.activate([
            dateTitleSeperatorLine.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: -20),
            dateTitleSeperatorLine.leftAnchor.constraint(equalTo: dreamTextField.leftAnchor),
            dateTitleSeperatorLine.widthAnchor.constraint(equalTo: dreamTextField.widthAnchor),
            dateTitleSeperatorLine.heightAnchor.constraint(equalToConstant: 0.7)
            ])
        
        let tagsTitleSeperatorLine = UIView()
        tagsTitleSeperatorLine.backgroundColor = .lightGray
        tagsTitleSeperatorLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagsTitleSeperatorLine)
        NSLayoutConstraint.activate([
            tagsTitleSeperatorLine.topAnchor.constraint(equalTo: tagsField.bottomAnchor, constant: -20),
            tagsTitleSeperatorLine.leftAnchor.constraint(equalTo: dreamTextField.leftAnchor),
            tagsTitleSeperatorLine.widthAnchor.constraint(equalTo: dreamTextField.widthAnchor),
            tagsTitleSeperatorLine.heightAnchor.constraint(equalToConstant: 0.7)
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
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor),
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
