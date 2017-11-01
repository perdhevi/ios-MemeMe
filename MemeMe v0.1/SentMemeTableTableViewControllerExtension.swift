//
//  SentMemeTableTableViewControllerExtension.swift
//  MemeMe v2.0
//
//  Created by Raditya on 6/23/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import Foundation
import UIKit


extension SentMemeTableTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMemeCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemeTableCell", for: indexPath) as! SentMemeTableViewCell
        
        let meme = getMeme(atIndex: indexPath.row)
        
        // Configure the cell...
        cell.setupCellWith(meme: meme)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewMeme(at: indexPath.row)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            _ = deleteMeme(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }   
    }
    
}
