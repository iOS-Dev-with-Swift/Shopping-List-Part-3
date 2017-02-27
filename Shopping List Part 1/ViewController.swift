//
//  ViewController.swift
//  Shopping List Part 1
//
//  Created by LT Carbonell on 2/26/17.
//  Copyright © 2017 LT Carbonell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shoppingList: [String] = []
    let cellIdentifier = "cell"
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var newItem: UITextField!
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if defaults.object(forKey: "list") != nil {
            shoppingList = defaults.object(forKey: "list") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = shoppingList.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let item = shoppingList[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            shoppingList.remove(at: indexPath.row)
            defaults.setValue(shoppingList, forKey: "list")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        if newItem.text != "" {
            shoppingList.append(newItem.text!)
            defaults.set(shoppingList, forKey: "list")
            listTable.reloadData()
            newItem.text = ""
        }
        
    }
    
}

