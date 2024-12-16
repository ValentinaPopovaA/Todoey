//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Валентина Попова on 13.12.2024.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categories = [CategoryModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        setupUI()
        makeContstraints()
        loadCategories()
    }
    
    // MARK: - TableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifire, for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        cell.categoryLabel.text = category.name
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoListVC = TodoListViewController()
        if let indexPath = tableView.indexPathForSelectedRow {
            todoListVC.selectedCategory = categories[indexPath.row]
        }
        navigationController?.pushViewController(todoListVC, animated: true)
        saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func addButtonPressed() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (acion) in
            let newCategory = CategoryModel(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "Create new category"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        categoryTableView.reloadData()
    }
    
    func loadCategories() {
        let request : NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        categoryTableView.reloadData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemMint
        view.addSubview(categoryTableView)
    }
    
    func makeContstraints() {
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: view.topAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
