//
//  ViewController.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit



class MainViewController: UITableViewController {
    
    lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        return searchController
    }()
    
    private func cellIdentifier() -> String {
        return "CellID"
    }
    
    
    let inputFormView = InputFormView()
    
    private func setupUI() {
        //inputContainerView
        view.addSubview(inputFormView)
        inputFormView.delegate = self
        inputFormView.isHidden = true
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
    
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationItem.rightBarButtonItem = addButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Dream Portal"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    @objc func handleAddButton() {
        inputFormView.isHidden = false
    }
    
    func handleCellRegistration() {
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: cellIdentifier())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        handleCellRegistration()
        setupNavigationBar()
        setupUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MainViewController: InputFormViewDelegate {
    func didTapSaveButton(forView view: InputFormView) {
        guard let title = view.dreamTextField.inputTextField.text else { return }
        guard let date = view.dateField.inputTextField.text else { return }
        guard let tags = view.tagsField.inputTextField.text else { return }
        guard let descrition = view.descriptionTextView.text else { return }
        
        let dream = Dream(title: title, dateString: date, tags: [tags], description: descrition)
        DreamDatabase.database.data.append( dream)
        tableView.reloadData()
        view.isHidden = true
    }
}

extension MainViewController:  UISearchControllerDelegate {
     
}
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DreamDatabase.database.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dream = DreamDatabase.database.data[indexPath.row]
        let dreamCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(), for: indexPath) as! TableViewCustomCell
        dreamCell.textLabel?.text = dream.title
        dreamCell.detailTextLabel?.text = dream.dateString
        return dreamCell
    }
}

