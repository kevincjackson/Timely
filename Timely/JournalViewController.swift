//
//  JournalViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class JournalViewController: UITableViewController {
    
    private var timingEntries = [TimingEntry]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timingEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timingEntry = timingEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        cell.imageView?.image = timingEntry.timing.image
        cell.textLabel?.text = "I was \(timingEntry.timing.name)"
        cell.detailTextLabel?.text = "on \(timingEntry.date.formatted)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timingEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: TimingSelectable
extension JournalViewController: TimingSelectable {
    
    func timingSelected(_ timingEntry: TimingEntry) {
        timingEntries.insert(timingEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
