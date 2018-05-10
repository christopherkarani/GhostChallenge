//
//  TableViewCustomCell.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

/*
var title: String
var dateString: String
var tags: [String]
var description: String
*/

class TableViewCustomCell: UITableViewCell {
    
    var dream: Dream? {
        didSet {
            guard let dream = dream else { return }
            handleAttributedTextCreation(withDream: dream)
        }
    }
    
    func handleAttributedTextCreation(withDream dream: Dream) {
        
        //begining, title
        let mutableAttrString = NSMutableAttributedString(string: "Title: ", attributes: [
            .font : UIFont.boldSystemFont(ofSize: 16),
            .underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        let dreamTitleAttrStringValue = NSAttributedString(string: "\(dream.title) \n", attributes: [.font : UIFont.systemFont(ofSize: 16)])
        
        //date Atrr String ____
        let dreamDateAtrrStringTitle = NSAttributedString(string: "Date: ", attributes: [
            .font : UIFont.boldSystemFont(ofSize: 16),
            .underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        let dreamDateAtrrStringValue = NSAttributedString(string: "\(dream.dateString) \n", attributes: [.font : UIFont.systemFont(ofSize: 16)])
        
        //tags atrributed string ____
        let dreamTagAtrrStringTitle = NSAttributedString(string: "Tags: ", attributes: [
            .underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
            .font: UIFont.boldSystemFont(ofSize: 16)])
        let dreamTagAtrrStringValue = NSAttributedString(string: "funny, calling, jubilant \n", attributes: [.font : UIFont.systemFont(ofSize: 16)])
        
        //Descrition Atrr String section
        let dreamDescriptionAtrrTitle = NSAttributedString(string: "Description \n", attributes: [
            .underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
            .font: UIFont.boldSystemFont(ofSize: 16)])
        
        let dreamDescritionAtrrValue = NSAttributedString(string: "\(dream.description)", attributes: [.font : UIFont.boldSystemFont(ofSize: 16)])
        
        let orderArrayOfAtrributedStrings = [dreamTitleAttrStringValue, dreamDateAtrrStringTitle, dreamDateAtrrStringValue, dreamTagAtrrStringTitle, dreamTagAtrrStringValue, dreamDescriptionAtrrTitle, dreamDescritionAtrrValue]
        
        orderArrayOfAtrributedStrings.forEach { (attributedString) in
            mutableAttrString.append(attributedString)
        }
        textView.attributedText = mutableAttrString
    }
    
    
    var textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableViewCustomCell: UsingProgrammabaleConstraints  {
    func setupUI() {
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            textView.rightAnchor.constraint(equalTo:contentView.rightAnchor)
            ])
    }
}
