//
//  ItemStore.swift
//  HomeItemRecorder
//
//  Created by Christopher Stromberg on 4/1/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
//    init() {
//        for _ in 0..<5 { createItem()
//        }
//    }
    
    // Method to remove a specific item from index using tableview deletion
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
            
        }
    }
    // Method to move rows within a tableview
        
        func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
            if fromIndex == toIndex {
                return
            }
            
            // Get reference to object being moved so you can reinsert it 
            let movedItem = allItems[fromIndex]
            
            // Remove item from array
            allItems.removeAtIndex(fromIndex)
            
            // Insert item in array at new location
            allItems.insert(movedItem, atIndex: toIndex)
        }
    

    
    
    
    
    
}














