//
//  TeamTableViewTableViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/26/20.
//

import UIKit
import CloudKit

class TeamTableViewTableViewController: UITableViewController {

   
    var team: String = ""
    
    var player: String = ""
    
    var selectedPlayer: String = ""
    
    var playerID: CKRecord.ID = CKRecord.ID()
    
    // set variable for ScoreViewController or EventsCollectionViewController segues
    var eventVariable: Bool = false
    
    var eventN: String = ""
    
    var eventDate: Date = Date()
    
  let manager = TeamDataLoad()
    
  let playerSearch = UpdateTeamTotals()
    
  let PlayerCheck = TeamPlayerCheck()
    
  let dispatchGroup = DispatchGroup()
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    } //viewdidLoad

    
    lazy var resultsArray = manager.rosterPicQuery(tName: team)
    
   
    func locationItem(at index:IndexPath) -> String {
        resultsArray.rosterArray[index.item]
        
    } //locationItem func
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }  //numberOfSections

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // let rosterLength = resultsArray.count
        
        let rosterLength = resultsArray.rosterArray.count
        
      return rosterLength
    }  //numberOfRowsInSection

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        
        player = resultsArray.rosterArray[indexPath.row]
        
        cell.textLabel?.text = player
        
            
        let photoPic = resultsArray.rosterPicArray[indexPath.row]
        let imageData = NSData(contentsOf: photoPic.fileURL!)
       // print("imageData: ", imageData as Any)
        
        if let image = UIImage(data: imageData! as Data) {
        
        cell.imageView?.image = image
        
        } //if image

         
        return cell
        
    }  //tableView func
        
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // Runs but doesn't select correct cell
      //  let selectedPlayer = UITableViewCell()
        
        let selectedPlayer = locationItem(at: indexPath)
       print("selectedPlayer: ", selectedPlayer)
      
        
        // Add if condition for event not "" to go to sponsor collectionview list
        if eventVariable == false {
        
        performSegue(withIdentifier: "toPlayer", sender: selectedPlayer)
            print("event = false. segue toPlayer")
       
        } else {
          
            performSegue(withIdentifier: "toSponsorList", sender: selectedPlayer)
            print("event = true, segue toSponsorList")
            
        } //if for toSponsorList
        
    } // tableView func didSelectRowAt
    
  
    
    // Add swipe delete function here
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
       
      //  if editingStyle == UITableViewCell.EditingStyle.delete {
            

            // verify with user to delete player
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this player?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
               // print("Ok button tapped")
                deletePlayer()
                
            })  // UIAlertAction ok
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
               // print("Cancel button tapped")
            } //UIAlertAction cancel
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
           
            // delete player **************
          func deletePlayer() {
              
          let teamN = team
          print("teamN in swipe delete: ", teamN)
          
            let playerN = resultsArray.rosterArray[indexPath.row]
              
          //  let playerN = resultsArray[indexPath.row] as! String
            
              print("playerN in swipe delete: ", playerN)
          
          
          let recordTeam = playerSearch.queryPlayer(pName: playerN, team: teamN)
          
          playerID = recordTeam.playID

         // print("playerID in delete: ", playerID)
          

          CKContainer.default().publicCloudDatabase.delete(withRecordID: playerID) {(recordID, error) in
             
              //NSLog("OK error")
              
           //  } { record, error in
              DispatchQueue.main.async {
                 if error == nil {
                      
                  } else {
                     let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                     ac.addAction(UIAlertAction(title: "OK", style: .default))
                    //  self.persent(ac, animated: true)
                  }  // else
                  
            } //if error
           } // DispatchQueue

            resultsArray.rosterArray.remove(at: indexPath.row)
            // resultsArray.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
              
              
          var textMessDelete = playerN
          
          textMessDelete.append(" removed from ")
          
          textMessDelete.append(teamN)
          
         print("textMessDelete: ", textMessDelete)
          
         let dialogMessage = UIAlertController(title: "Player Removed", message: textMessDelete, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
              
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)

              
              } // func deletePlayer
            
            
            
    // This code to insert a player doesn't work yet
    /*
    } else {
        
        //Swipe code to add player to roster
      //  if editingStyle == UITableViewCell.EditingStyle.insert {
        if editingStyle == .insert {
            
            let playerN = resultsArray[indexPath.row] as! String
            
            //Duplicate team and player detected
            let check = PlayerCheck.TeamPlayer(team: team, player: playerN)
            
            print("check.count: ", check.count)
            
            if check.count > 0 {
              
                
                // Create new Alert
                 let dialogMessage = UIAlertController(title: "Duplicate", message: "Duplicate Player detected. Re-enter Player. ", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    // print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
                
            }  else {
                
                let playerN = resultsArray[indexPath.row] as! String
                
                let recordPlayer =
                
                CKRecord(recordType: "team")
                
                recordPlayer["player"] = playerN
        
                recordPlayer["teamName"] = team
            
            recordPlayer["TotAttempts"] = 0
            
            recordPlayer["TotMakes"] = 0
            
            recordPlayer["TotPercentage"] = 0
            
            recordPlayer["LastDate"] = Date()
             
            
                CKContainer.default().publicCloudDatabase.save(recordPlayer) { record, error in
                    DispatchQueue.main.async {
                       if error == nil {
                            
                        } else {
                           let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                           ac.addAction(UIAlertAction(title: "OK", style: .default))
                          //  self.persent(ac, animated: true)
                        }  // else
                        
                  } //if error
                 } // DispatchQueue
            
                resultsArray.insert(playerN, at: indexPath.row)
                tableView.insertRows(at: [indexPath], with: .fade)
                
               /*
                let cell = tableView.dequeueReusableCell(withIdentifier: "playerName", for: indexPath)
              
                // Configure the cell...

                cell.textLabel?.text = locationItem(at:indexPath)
                */
                
                
                
            var textDisplay = playerN
            
            textDisplay.append(" added to ")
            
            textDisplay.append(team)
            
           print("textDisplay: ", textDisplay)
            
           //  messageTextView.text = textDisplay
                
                let dialogMessage = UIAlertController(title: "Player Added", message: textDisplay, preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)

                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)

              
            
            }  //if check.count >0 duplicate player
       
        
       } // if editingStyle insert
             */
             // insert player code end
 
 
    } // Swipe
        
    
    } // override func tableview for delete
    
   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        
        if segue.identifier == "toPlayerMgmt" {
          
                    print("toPlayerMgmt Segue")
             //   if let selectedPlayer = sender as? String {
               
                    let vcRoster = segue.destination as! UINavigationController
                   
                    let vcScore = vcRoster.viewControllers.first as! PlayerManagement
                    
                 //  vcScore.playerN = selectedPlayer
                    
                  //  vcScore.playerN = player
                    
                  //  print("vcScore.playerN: ", vcScore.playerN)
                    
                    print("vcScore.team ", vcScore.name)
                
                vcScore.title = self.team
                vcScore.name = self.team

           //     } // SelectedPlayer
             //   }   // "toPlayerMgmt segue PlayerManagement
            
            } //toPlayerMgmt
        
           if segue.identifier == "toPlayer" {
               
              //  if segue.destination is ScoreViewController {
                    
                    print("toPlayer Segue")
                    
                    if let selectedPlayer = sender as? String {
                   
                        let vcRoster = segue.destination as! UINavigationController
                       
                        let vcScore = vcRoster.viewControllers.first as! ScoreViewController
                        
                       vcScore.playerN = selectedPlayer
                        
                      //  vcScore.playerN = player
                        
                        print("vcScore.playerN: ", vcScore.playerN)
                        
                        print("vcScore.team ", vcScore.team)
                    
                    vcScore.title = self.team
                    vcScore.team = self.team
                    
                    } // if selected player
                    }  // segue toPlayer
            
                 if segue.identifier == "toSponsorList" {
                    
                                    print("toSponsorList")
                             
                    if let selectedPlayer = sender as? String {
                                    let vcRoster = segue.destination as! UINavigationController
                                   
                                    let vcScore = vcRoster.viewControllers.first as! SponsorListViewController
                                    
                                 //  vcScore.playerN = selectedPlayer
                                    
                                  //  vcScore.playerN = player
                                    
                                  //  print("vcScore.playerN: ", vcScore.playerN)
                                    
                                
                   //     var eventTitle = team
                    
                   // eventTitle.append(",")
                   //     eventTitle.append(selectedPlayer)
                    //    eventTitle.append("-")
                    
                    var eventTitle = selectedPlayer
                    eventTitle.append(" ")
                    eventTitle.append(eventN)
                 //  let eventTitle = selectedPlayer
                        
                    print("eventTitle in TVC: ", eventTitle)
                        
                        
                            vcScore.title = eventTitle
                            vcScore.team = self.team
                            vcScore.playerName = selectedPlayer
                        vcScore.eventName = eventN
                        vcScore.eventDate = eventDate
                            
                        print("team in TVC: ", vcScore.team)
                      //  print("selectedPlayer in TVC: ", selectedPlayer)
                        print("playerName in TVC: ", vcScore.playerName)
                        print("eventName in TVC: ", vcScore.eventName)
                        print("eventDate in TVC: ", eventDate)
                           

                    } // if selected player
                    } //toSponsorList segue
                        
                        
                        
                    
           // } // to ScoreViewController
          
         
            
        } // prepare func
    
    
    @IBAction func unwindScoreViewControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from ScoreViewController")
        
     }  // UIStoryboardSegue
    
    
    
    
   
   @IBAction func unwindPlayerManagementCancel(segue: UIStoryboardSegue) {
        
  
        print("unwind from PlayerManagement")
        
        print("team name in unwindPlayerManagement: ", team)
     
    
    dispatchGroup.notify(queue: .main) { [self] in
     
        dispatchGroup.enter()
    
    resultsArray = manager.rosterPicQuery(tName: team)
  
        var counter: Int = 0
        while counter <= 700000000 {
            counter += 1
        } // while loop
        
    self.tableView.reloadData()
        
        dispatchGroup.leave()
        
    } // dispatchGroup.notify
     
  
    
   }  // UIStoryboardSegue  unwindPlayerManagementCancel
    
    @IBAction func unwindSponsorListControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from SponsorListController")
        
     }  // UIStoryboardSegue
    
    
    
    
    
    
    
 }   // class TeamTableViewController

