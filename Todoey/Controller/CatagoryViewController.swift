//
//  CatagoryTableViewController.swift
//  Todoey
//
//  Created by Shuntian Li on 2018-02-08.
//  Copyright © 2018 Shuntian Li. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    

    override func viewDidLoad() {
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategory()
        
        super.viewDidLoad()
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Category", message: "Add new category", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "new category name"
            
            textField = alertTextField
        }
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            // save new category here
            self.save(category: newCategory)
        }
        
        alert.addAction(alertAction)
    
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    // MARK: - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1 //Nil Coalescing Operator
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
   
    }
    
    
    // MARK: - Data Manipulation
    
    func save(category: Category){
        do{
            try realm.write {
                
                realm.add(category)
            }
            print("Save successfully")
            
        } catch {
            
            print("Error saving new category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategory(){
        
        categories = realm.objects(Category.self)
    
        self.tableView.reloadData()
    }
    
    
}
























