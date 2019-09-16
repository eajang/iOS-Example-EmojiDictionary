//
//  EmojiTableViewController.swift
//  TableViewDemo
//
//  Created by Eunae Jang on 16/09/2019.
//  Copyright © 2019 Eunae Jang. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
        Emoji(symbol: "👮‍♀️", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows in each section
        if section == 0 {
            return emojis.count
        } else {
            return 0
        }
    }

    // indexPath: description of the cell that you want to display in each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse the cell which is not shown anymore
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        // Configure the cell...
        // cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        // cell.detailTextLabel?.text = emoji.description
        cell.update(with: emoji)
        
        cell.showsReorderControl = true
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = emojis[indexPath.row]
//        print("\(emoji.symbol) \(indexPath)")       // example output: 😀 [0, 0]
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
    }
    
    // Remove the minus symbol on the leftside in editing mode
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            
            let navigationController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navigationController.viewControllers.first as! AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
        }
    }
 
    @IBAction func unwindToEmojiTableViewController(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {
            return
        }
        
        // where the segue started
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            // check whether the emoji edited or created
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // edited emoji
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // created emoji
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

}
