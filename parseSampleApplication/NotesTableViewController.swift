//
//  NotesTableViewController.swift
//  parseSampleApplication
//
//  Created by Alexander Karpov on 05.02.16.
//  Copyright © 2016 Alex Karpov. All rights reserved.
//

import UIKit
import Parse

class NotesTableViewController: UITableViewController {

    var notes : [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: "refreshNotes", forControlEvents: .ValueChanged)
        self.refreshControl = refresh
        
        refreshNotes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    let pageObjectsCount = 30
    var currentPage = 0
    
    func refreshNotes() {
        let query = PFQuery(className:"Note")
        
        query.limit = pageObjectsCount
        query.skip = currentPage * pageObjectsCount
        
        query.findObjectsInBackgroundWithBlock { 
            (objects, error) -> Void in
            self.refreshControl?.endRefreshing()
            if let e = error {
                print("error while getting objects -> \(e.localizedDescription)")
            } else {
                print("got objects -> \(objects)")
                if let noteObjects  = objects {
                
                    if self.currentPage != 0 {
                        self.notes += noteObjects.map({return Note(parseObject: $0)})
                    } else {
                        self.notes = noteObjects.map({return Note(parseObject: $0)})
                    }
                    performUI{
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NotePreviewTableViewCell", forIndexPath: indexPath) as! NotePreviewTableViewCell

        cell.titleLabel.text = notes[indexPath.row].title
        cell.descriptionLabel.text = notes[indexPath.row].text
        // Configure the cell...

        return cell
    }
    
    @IBAction func addNoteAction(sender: AnyObject) {
        self.performSegueWithIdentifier("moveToNoteSegue", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            notes[indexPath.row].deleteFromParse(success: { 
                performUI{tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)}
                self.notes.removeAtIndex(indexPath.row)
            }, error: { 
                errorText in
                print("error while deleting note at index \(indexPath.row)")
            })
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("moveToNoteSegue", sender: notes[indexPath.row])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "moveToNoteSegue" {
            let dvc = segue.destinationViewController as! NoteViewController
            dvc.note = sender as? Note
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
