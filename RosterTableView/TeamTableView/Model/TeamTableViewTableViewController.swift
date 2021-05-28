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
    
   // var roster: String = ""
    
   // var rosterPhoto = CKAsset.self
    
  let manager = TeamDataLoad()
    
  let playerSearch = UpdateTeamTotals()
    
  let PlayerCheck = TeamPlayerCheck()
    
  let refreshTable = ReloadTableView()
    
    
     
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      // self.refreshControl?.addTarget(self, action: #selector(TeamTableViewTableViewController.handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
        
        
       // refreshTable.upDateTable(team: team)
        
       // self.tableView.reloadData()
        
        
       // tableView?.dataSource
       // tableView?.delegate = self
        
       // tableView.delegate = self
       // tableView.dataSource = self
        
      //  NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    } //viewdidLoad

    
    @objc func handleRefresh (refreshControl: UIRefreshControl) {
      
       //  resultsArray = manager.rosterPicQuery(tName: team)
         
        print("team in handleRefresh: ", team)
        
        refreshTable.upDateTable(team: team)
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
        //self.tableView.reloadData()
        refreshControl.endRefreshing()
         
     }  // func handleRefresh
   
    
    // Refresh tableView - This code doesn't do anything
    /*
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        refreshTable.upDateTable(team: team)
        
        self.tableView.reloadData()

        } // viewWillAppear
    */
    
    
  //  lazy var resultsArray = manager.rosterQuery(tName: team)
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

        //old code for just displaying names in roster
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerName", for: indexPath)
      
        // Configure the cell...

        cell.textLabel?.text = locationItem(at:indexPath)
        */
        
        // Add image to tableView - need to access image URL in Cloudkit. Store in resultsArray? Or create a separate array for the images and call it here?
       // cell.imageView?.image = locationItem(at: indexPath)
         
        return cell
        
    }  //tableView func
        
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // Runs but doesn't select correct cell
      //  let selectedPlayer = UITableViewCell()
        
        let selectedPlayer = locationItem(at: indexPath)
       print("selectedPlayer: ", selectedPlayer)
      
        performSegue(withIdentifier: "toPlayer", sender: selectedPlayer)
        
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
          

        //  messageTextView.text = textMessDelete
         
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
            
            

      //  } // if delete editing Style
    
            
    // This code to insert a player doesn't run
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
             // insert player code
 
 
    } // Swipe
        
    
    } // override func tableview for delete
    
   
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        /*
        if let playerManagement = segue.destination as? PlayerManagement { playerManagement.teamTableViewTableViewController = self
        } // playerManagement
        */
        
        
        if segue.identifier == "toPlayerMgmt" {
          //  if segue.destination is PlayerManagement {
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
            
            } else if segue.identifier == "toPlayer" {
               
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
                        
                    } // if selecterdPlayer

                    
                } // to ScoreViewController
          
          //  }  //  if destination "toPlayer segue
        
        
        
         // This doesn't work yet
        
      /*
    if let scoreViewController = segue.destination as? ScoreViewController { scoreViewController.TeamTableViewTableViewController = self}
        */
        
        
      //  let vcRoster = segue.destination as! UINavigationController
       
       // let vcScore = vcRoster.viewControllers.first as! ScoreViewController
    
       // print("selectedPlayer in prepare: ", selectedPlayer)
    
        // This is the old code that worked just for the "toPlayer" segue
        /*
        if let selectedPlayer = sender as? String {
       
            let vcRoster = segue.destination as! UINavigationController
           
            let vcScore = vcRoster.viewControllers.first as! ScoreViewController
            
           vcScore.playerN = selectedPlayer
            
          //  vcScore.playerN = player
            
            print("vcScore.playerN: ", vcScore.playerN)
            
            print("vcScore.team ", vcScore.team)
        
        vcScore.title = self.team
        vcScore.team = self.team
            
        } // if selecterdPlayer
        */
        
            
        } // prepare func
    
    
    @IBAction func unwindScoreViewControllerCancel(segue: UIStoryboardSegue) {
        
        print("unwind from ScoreViewController")
        
     }  // UIStoryboardSegue
    
    
    
    /*  // This code doesn't seem to do anything
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.tableView.reloadData()
    }
    */
    
    
   
   @IBAction func unwindPlayerManagementCancel(segue: UIStoryboardSegue) {
        
  //  @IBAction func unwindPlayerManagementCancel(segue: backToTableView) {
    
        //This didn't refresh with new player
        //tableView.reloadData()
        print("unwind from PlayerManagement")
        
        print("team name in unwindPlayerManagement: ", team)
    
    
    refreshTable.upDateTable(team: team)
     
    self.tableView.reloadData()
     
    
    
    
    /*
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
    */
    
   // self.refreshControl?.addTarget(self, action: #selector(TeamTableViewTableViewController.handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)
    
    
    
    
    
   }  // UIStoryboardSegue  unwindPlayerManagementCancel
    
    
      // refreshTable.upDateTable(team: team)
        
     //  self.tableView.reloadData()
    
      // navigationController?.popViewController(animated: true)
        
        
       /*
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
               
                print("DispatchQueue tableView reloadView")
             
             //   let resultsArray = self.manager.rosterPicQuery(tName: self.team)
    
                self.tableView.reloadData()
                
           }  // async
        }  // DispatchQueue
       */
        
        // This code doesn't work
       /*
       let resultsArray = manager.rosterPicQuery(tName: team)
        
        
        func locationItem(at index:IndexPath) -> String {
            resultsArray.rosterArray[index.item]
            
        } //locationItem func
        
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
        }  //numberOfSections

        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            // let rosterLength = resultsArray.count
            
            let rosterLength = resultsArray.rosterArray.count
            
            print("rosterLength in PlayerManagement rewind", rosterLength)
            
          return rosterLength
        }  //numberOfRowsInSection

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell = UITableViewCell()
            
            player = resultsArray.rosterArray[indexPath.row]
            
            print("player in PlayerManagement rewind: ", player)
            
            cell.textLabel?.text = player
            
                
            let photoPic = self.resultsArray.rosterPicArray[indexPath.row]
            let imageData = NSData(contentsOf: photoPic.fileURL!)
           // print("imageData: ", imageData as Any)
            
            if let image = UIImage(data: imageData! as Data) {
            
            cell.imageView?.image = image
            
            } //if image

            //old code for just displaying names in roster
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerName", for: indexPath)
          
            // Configure the cell...

            cell.textLabel?.text = locationItem(at:indexPath)
            */
            
            // Add image to tableView - need to access image URL in Cloudkit. Store in resultsArray? Or create a separate array for the images and call it here?
           // cell.imageView?.image = locationItem(at: indexPath)
            
            
            return cell
          
        }  //tableView func
       
        */
        
        
      //  tableView.reloadItems()
     // self.tableView.reloadData()
        
       /*
        DispatchQueue.main.async{
            print("DispatchQueue tableView reloadView")
            self.tableView.reloadData()
            
        }  // DispatchQueue
        */
        
        /*
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
               
                print("DispatchQueue tableView reloadView")
                
                self.tableView.reloadData()
         
          
          }  // async
        }  // DispatchQueue
       */
        
     
    
    
    
    
    

    /*
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.tableView.reloadData()
        
    } // override func dismiss
    */
    
    
    // this IBAction func doesn't fire
    /*
    @IBAction func TeamTableViewTableViewController(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                
                print("DispatchQueue IBAction func")
                self.tableView.reloadData()
            }
        }
    }
    */
    
    /*
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.tableView.reloadData()
    }
    */
    
 }   // class TeamTableViewController

