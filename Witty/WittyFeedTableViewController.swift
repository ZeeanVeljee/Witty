//
//  WittyFeedTableViewController.swift
//  Witty
//
//  Created by Zeean Veljee on 17/04/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import UIKit
import Firebase

class WittyFeedTableViewController: UITableViewController {
    
    var wits = [Wit]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.estimatedRowHeight = 215
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.darkGray

        DataService.dataService.WIT_REF.observe(.value, with: { snapshot in
            print(snapshot.value)
            
            //self.wits = []
            
            let i = snapshot.childrenCount
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let wit = Wit(key: key, dictionary: postDictionary)
                        //let wit = postDictionary
                        //print(snap)
                        //print(key)
                        //print(wit)
                        //print(postDictionary)
                            self.wits.insert(wit, at: 0)
                        if self.wits.count == Int(i) {
                            self.tableView.reloadData()
                            //print(self.wits[0])
                        }
                    }
                }
            }
            
            //self.tableView.reloadData()
            
        })
        /*tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.darkGray*/
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wit = wits[(indexPath as NSIndexPath).row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wittyCell", for: indexPath) as? WittyTableViewCell{

        // Configure the cell...
            cell.witText.text = wit.witText
            cell.witText.textColor = UIColor.white
            cell.votesLabel.text = "Votes: \(wit.witVotes)"
            cell.usernameLabel.text = wit.username
            cell.witView.layer.cornerRadius = 20
            cell.witView.clipsToBounds = true
            cell.backgroundColor = UIColor.darkGray
            cell.witView.backgroundColor = UIColor.darkGray
            cell.witView.layer.borderWidth = 1
            cell.witView.layer.borderColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0).cgColor
            cell.wittyProfileImage.image = UIImage(named: "\((indexPath.row)%6)")
            
            cell.voteRef = DataService.dataService.WIT_REF.child(wit.witKey).child("votes")
            
            cell.voteRef.observeSingleEvent(of: .value, with:{ snapshot in
                
                if let thumbsUpDown = snapshot.value as? NSNull {
                    print(thumbsUpDown)
                    cell.voteImage.image = UIImage(named: "Unvote")
                }
                else {
                    cell.voteImage.image = UIImage(named: "Vote")
                }
            })


        return cell
        }
        else {
            return WittyTableViewCell()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
