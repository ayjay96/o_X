//
//  NetworkGamesTableViewController.swift
//  o_X
//
//  Created by avarn127 on 7/5/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesTableViewController: UITableViewController {
    @IBOutlet weak var networkBackButton: UIBarButtonItem!
    
    @IBOutlet weak var newGameButton: UIBarButtonItem!
     var tableArray =  [OXGame]()

    @IBAction func networkBackButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
        
    
    
    override func viewDidAppear(animated: Bool) {
        
        //Give me the fucking game list you hoe
        //the game list is in the closure parameter
        OXGameController.sharedInstance.getGameList{ (games, error) in
            if error == nil {
                print("here are games")
                print(games!)
                self.tableArray = games!
                self.tableView.reloadData()
            }
            else {
                
            }
            
        }
       
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func newNetworkGame(sender: UIBarButtonItem) {
    
        OXGameController.sharedInstance.createGame(OXGameController.sharedInstance.getCurrentGame().ID) { (game, error) in
            if error == nil {
                 self.performSegueWithIdentifier("segue", sender: self)
            }
            else
            {
                let alert = UIAlertController (title: "ERROR" , message: "Could not create game" , preferredStyle:  UIAlertControllerStyle.Alert)
                let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                alert.addAction(alertAction1)
                self.presentViewController(alert, animated: true, completion: nil)
            
 
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
        return tableArray.count
        // #warning Incomplete implementation, return the number of rows
       
    }

   

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = "ID: " + String(tableArray[indexPath.row].ID) + "Host: " + tableArray[indexPath.row].host
        return cell

        // Configure the cell...

        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("segue", sender: self)
        OXGameController.sharedInstance.joinGame(tableArray[indexPath.row].ID, onCompletion: { (game, error)  in
            if error == nil {
                self.performSegueWithIdentifier("segue", sender: self)
            }
                
                else {
                    let alert = UIAlertController (title: "ERROR" , message: error , preferredStyle:  UIAlertControllerStyle.Alert)
                    let alertAction1 = UIAlertAction( title: "Dismiss" , style: .Cancel, handler: nil)
                    alert.addAction(alertAction1)
                    self.presentViewController(alert, animated: true, completion: nil)


            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let road = segue.destinationViewController as? BoardViewController
        road?.networkMode = true
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
