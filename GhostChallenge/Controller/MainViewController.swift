//
//  ViewController.swift
//  GhostChallenge
//
//  Created by Chris Karani on 5/8/18.
//  Copyright © 2018 Chris Karani. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let dataSource = MainTableViewDataSource()
    private let inputFormView = InputFormView()

    lazy var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        //searchController.delegate = self
        searchController.searchBar.delegate = self
//        searchController.searchBar.scopeButtonTitles = ["Title", "Date", "Tags"]
//        searchController.searchBar.showsScopeBar = true
        return searchController
    }()
    
    public static func cellIdentifier() -> String {
        return "CellID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        handleTableViewSetup()
        setupNavigationBar()
        setupGestureRecognizers()
        setupNotificationObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserver()
    }

    override var canResignFirstResponder: Bool {
        return true
    }
}


extension MainViewController: InputFormViewDelegate {
    func didTapSaveButton(forView view: InputFormView) {
        guard let title = view.dreamTextField.inputTextField.text else { return }
        guard let date = view.dateField.inputTextField.text else { return }
        guard let tags = view.tagsField.inputTextField.text else { return }
        guard let descrition = view.descriptionTextView.text else { return }
        
        let tagsArray = tags.components(separatedBy: " ")
        
        let dream = Dream(title: title, dateString: date, tags: tagsArray, description: descrition)
        DreamDatabase.DatabaseData.add(toDatabase: dream)
        tableView.reloadData()
        handleViewDismisAction()
        view.isHidden = true
    }
}

extension MainViewController:  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchFunctionality(withSearchBar: searchBar)
    }
    
    private func handleSearchFunctionality(withSearchBar searchbar: UISearchBar) {
        guard let searchText = searchbar.text else { return }
        
        
        dataSource.filteredDreams = dataSource.dreams.filter({ (dream) -> Bool in
            return dream.title.localizedLowercase.contains(searchText.localizedLowercase)
        })
        if searchText.isEmpty {
            dataSource.filteredDreams = dataSource.dreams
        }
        
        self.tableView.reloadData()
    }
}

//MARK: Setup UI
extension MainViewController {
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "Dream Portal";
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor.rgb(44, 44, 44)
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 30),
        ]
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func presentInputForm() {
        blurrViewBackground()
        view.addSubview(inputFormView)
        inputFormView.delegate = self
        inputFormView.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        inputFormView.layer.cornerRadius = 5
        inputFormView.layer.borderWidth = 2
        inputFormView.layer.borderColor = UIColor.black.cgColor
        NSLayoutConstraint.activate([
            inputFormView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputFormView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputFormView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            inputFormView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -150)
            ])
    }
    
    // handles blurring of the background and possible animations
    fileprivate func blurrViewBackground() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let effect = UIBlurEffect(style: .regular)
        let visualEffect = UIVisualEffectView(effect: effect)
        visualEffect.frame = window.bounds
        view.addSubview(visualEffect)
    }
    
    func handleTableViewSetup() {
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: MainViewController.cellIdentifier())
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource.searchController = searchController
    }
}

// MARK: User Interaction
extension MainViewController {
    @objc fileprivate func handleViewDismisAction() {
        inputFormView.removeFromSuperview()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func setupGestureRecognizers() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleViewDismisAction))
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc func handleAddButton() {
        presentInputForm()
    }
}

// Notifications
extension MainViewController {
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(_:)), name: .dataRetrieved, object: nil)
    }
    
    fileprivate func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.dataRetrieved, object: nil)
    }
    
    @objc fileprivate func reloadTableView(_ notificiation: Notification) {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
}

