//
//  ReloadTableView.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 5/24/21.
//

import Foundation
import UIKit
import CloudKit


class ReloadTableView  {

let container = CloudKit.CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

var team: String = ""
    
var player: String = ""
    
let manager = TeamDataLoad()
    
    
func upDateTable(team: String)  {
        
    
     let resultsArray = manager.rosterPicQuery(tName: team)
    
    print("resultsArray in ReloadTableView Class: ", resultsArray.rosterArray)

    func locationItem(at index:IndexPath) -> String {
    resultsArray.rosterArray[index.item]
    
    } //locationItem func

     func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
    }  //numberOfSections



     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      // let rosterLength = resultsArray.count
    
     let rosterLength = resultsArray.rosterArray.count
        print("rosterLength in ReloadTableView: ", rosterLength)
    
     return rosterLength
    }  //numberOfRowsInSection


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = UITableViewCell()
    
    player = resultsArray.rosterArray[indexPath.row]
    
        print("player in ReloadTableView tableView: ", player)
        
        
    cell.textLabel?.text = player
        
    
    let photoPic = resultsArray.rosterPicArray[indexPath.row]
    let imageData = NSData(contentsOf: photoPic.fileURL!)
   // print("imageData: ", imageData as Any)
    
    if let image = UIImage(data: imageData! as Data) {
    
    cell.imageView?.image = image
    
    } //if image

    return cell
    
    }  //tableView func
  
}  // func upDateTable

}  // ReloadTableView class
