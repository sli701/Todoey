//
//  ViewController.swift
//  Todoey
//
//  Created by Shuntian Li on 2018-01-23.
//  Copyright © 2018 Shuntian Li. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        
        didSet{
            loadItem()
        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
    }



    // MARK: - Tableview Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
      
        if let item = todoItems?[indexPath.row] {
        
            cell.textLabel?.text = item.title

            cell.accessoryType = item.done == true ? .checkmark : .none
            
        } else {
            
            cell.textLabel?.text = "No Items Added"
            
        }

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                    
                    item.done = !item.done
                    
                }
            } catch {
                
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new Item"
            
            textField = alertTextField
            
            print("add the textField now")
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default)
        {(action) in
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try self.realm.write {
                        
                        let newItem = Item()
                        
                        newItem.title = textField.text!
                        
                        newItem.dataCreated = Date()
                        
                        currentCategory.items.append(newItem)
                    }
                    
                } catch{
                    
                    print("Error saing new items, \(error)")
                    
                }
                
            }
            
            self.tableView.reloadData()
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: Load items
    func loadItem(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        self.tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItem()
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
            }
        }
    }
}























