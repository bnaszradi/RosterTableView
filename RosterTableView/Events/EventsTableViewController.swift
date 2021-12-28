//
//  EventsTableViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/11/21.
//

import UIKit
import CloudKit

class EventsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }  //viewDidLoad

    // MARK: - Table view data source
    
    /*
    func locationItem(at index:IndexPath) -> String {
       resultsArray.rosterArray[index.item]
        
    } //locationItem func
    */

    var team: String = ""
    
   // let manager = QueryEvents()
    let manager = EventsList()
    /*
   // lazy var resultsArray = manager.eventsQuery(tName: team)
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    } // numberOfSections
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rosterLength = resultsArray.resultsNameArray.count
        
        return rosterLength
        
    }  // tableview numberofRowsInSection

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        let cell = UITableViewCell()
        
        let eventsN = resultsArray.resultsNameArray[indexPath.row]
        
      
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        
        let eventsD = dateFormatter.string(from: resultsArray.resultsDateArray[indexPath.row])
        
        var eventsL = eventsN
        
        eventsL.append("  ")
        
        eventsL.append(eventsD)
        
        cell.textLabel?.text = eventsL
        
        return cell
    } //override func TableView
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

     */
} // EventsTableViewController
