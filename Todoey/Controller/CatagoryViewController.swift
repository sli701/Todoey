//
//  CatagoryTableViewController.swift
//  Todoey
//
//  Created by Shuntian Li on 2018-02-08.
//  Copyright © 2018 Shuntian Li. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    // get the 小白板， 相当于github的staging area
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()
    

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
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            // save new category here
            self.saveCategory()
        }
        
        alert.addAction(alertAction)
    
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    // MARK: - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    // MARK: - Data Manipulation
    
    func saveCategory(){
        do{
            try context.save()
            print("Save successfully")
        } catch {
            print("Error saving new category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategory( with request: NSFetchRequest<Category> = Category.fetchRequest() ){
        
        do{
            categories = try context.fetch(request)
        } catch {
            print("loading data error \(error)")
        }
    }
    
    
}
























