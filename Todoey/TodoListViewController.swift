//
//  ViewController.swift
//  Todoey
//
//  Created by Валентина Попова on 05.12.2024.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var itemArray = ["Find", "Search", "Milk"]
    
    let defaults = UserDefaults.standard
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var toDoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todoey"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        searchBar.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
        setupUI()
        makeConstraints()
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifire, for: indexPath) as! ListCell
        
        let item = itemArray[indexPath.row]
        cell.itemLabel.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK: TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Add New Items
    @objc func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.toDoTableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = .systemMint
        view.addSubview(searchBar)
        view.addSubview(toDoTableView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 57),
            
            toDoTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toDoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

