//
//  ItemsViewController.swift
//  HomeItemRecorder
//
//  Created by Christopher Stromberg on 4/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemsStore: ItemStore!
    
    
    
    
    
    // Used to turn editing mode on and off for tableview
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // If you are currently in editing mode...
        if editing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
   
    
    // Used to add rows to existing tableview
    @IBAction func addNewItem(sender: AnyObject) {
        // Make a new index path for the 0th section, last row
//        let lastRow = tableView.numberOfRowsInSection(0)
//        let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        // Insert this new row into the table
//        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
        // Cannot add to tableview, need to add to the dataStore.
        // Create a new item and add it to the store
        let newItem = itemsStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemsStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            
            // Insert this new row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        // Get height of status bar.
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        
        // Set height of the tableview cells
        tableView.rowHeight = 65
        
        //setEditing(true, animated: true)
    }
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStore.allItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        // let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemsStore.allItems[indexPath.row]
        
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        // Configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "\(item.valueInDollars)"
        return cell
    }
    
    // Remove rows from tableview
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let item = itemsStore.allItems[indexPath.row]
            
            // ActionSheet creation confirming item deletion...
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            // Create UIAlertController
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil )
            
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
               
                // Remove the item from the store
                self.itemsStore.removeItem(item)
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            presentViewController(ac, animated: true, completion: nil)
            
//            // Remove the item from the store
//            itemsStore.removeItem(item)
//            
//            // Also remove that row from the table view with an animation
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
     
    }
    
    
    
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemsStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
