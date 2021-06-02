//
//  PlayerManagement.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 5/12/21.
//

import UIKit
import CloudKit
import MobileCoreServices
//import AVFoundation

class PlayerManagement: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   // var teamTableViewTableViewController: TeamTableViewTableViewController?=nil
    
    var name: String = ""
    
    var playerName: String = ""
    
    var pName: String = ""
    var tName: String = ""
    
    //var playerArray = [] as Array<String>
    
    let teamPlayerCheck = TeamPlayerCheck()
    
    let playerSearch = UpdateTeamTotals()
 
    var playerID: CKRecord.ID = CKRecord.ID()
    
    
    var pickerController = UIImagePickerController()
    
   var photoURL = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerController.delegate = self
        
      //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }  //override func
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    
    @IBOutlet weak var PlayerPhoto: UIImageView!
    
   
    @IBOutlet weak var Player: UITextField!
    
    
    
    @IBAction func AddPlayer(_ sender: Any) {
        // Check for team and player names in team type
        
        print("name: ", name)
        tName = name
        print("tName: ", tName)
        
        pName = Player.text!
        print("pName: ", pName)
        
        
            
            if pName == "" {
               
                // Create Player Alert
                 let dialogMessage = UIAlertController(title: "Missing Player", message: "Must enter Player", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            }  // if pName
            
     
       
       // print("check before alert: ", check.count)
        
        let check = teamPlayerCheck.TeamPlayer(team: tName, player: pName)
        
        print("check.count: ", check.count)
        
        if check.count > 0 {
          
            //Duplicate team and player detected
            
            // Create new Alert
             let dialogMessage = UIAlertController(title: "Duplicate", message: "Duplicate Player detected. Re-enter a different Player name. ", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
            
            
        }  else {
        
            if PlayerPhoto.image == nil {
                
            // Create Alert for missing photo
             let dialogMessage = UIAlertController(title: "Missing Photo", message: "Must select a new photo before updating existing Player photo", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
            
        }  // if missing photo alert

            
        let recordPlayer = CKRecord(recordType: "team")
        
        // Add photo
            
          //  let image = info[.originalImage] as? UIImage
            
            if let image = PlayerPhoto.image {
            
            let asset = CKAsset(fileURL: saveImageToFile(image))
           /*
          // let name = teamName.text!
          //  let playerName = Player.text!
          // let scoreDate = Date()
            
            // Get CKRecordID for team and player in team DB
            //Assign to playerID
            
            let playerRecord = playerSearch.queryPlayer(pName: playerName, team: name)
            
            playerID = playerRecord.playID
            print("playerID for photo: ", playerID)
            */
            
        recordPlayer["player"] = pName
    
        recordPlayer["teamName"] = tName
        
        recordPlayer["TotAttempts"] = 0
        
        recordPlayer["TotMakes"] = 0
        
        recordPlayer["TotPercentage"] = 0
        
        recordPlayer["LastDate"] = Date()
            
        recordPlayer["playerPhoto"] = asset
         
        
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
       
            // This code runs but the player added dialog doesn't run
            /*
            self.pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
            */
            
        var textDisplay = pName
        
        textDisplay.append(" added to ")
        
        textDisplay.append(tName)
        
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
           
            
            
        } // if - else to check for duplicate team and player

       
        
        } // if image
        
    } // AddPlayer
    
    
    
    
    
    
    
    
    // Update photo
    @IBAction func AddPhoto(_ sender: Any) {
        
        // Check for team and player names
        
       tName = name
        print("tname in AddPhoto: ", tName)
        
        pName = Player.text!
        print("pName in AddPhoto: ", pName)
        
                    
            if pName == "" {
               
                // Create Player Alert
                 let dialogMessage = UIAlertController(title: "Missing Player", message: "Must enter Player Name", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            } // if pName
            
      //  } // if tName
        
        
        
        
        let check = teamPlayerCheck.TeamPlayer(team: tName, player: pName)
        
        print("check.count in AddPhoto: ", check.count)
        
        if check.count == 0 {
          
            //Player not on roster yet
            
            // Create new Alert
             let dialogMessage = UIAlertController(title: "Player Missing", message: "Player not found on Team roster. Add Player to approprieate Team then update Player photo", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
            
            
        }  else {
   
            //Check if there is already a photo in player record
            let photoCheck = teamPlayerCheck.playerPhoto(team: tName, player: pName)
            
            if photoCheck.count > 0 {
                
                // Check to see if a photo is selected to update
                if PlayerPhoto.image == nil {
                    
                    // Create Alert for missing photo
                     let dialogMessage = UIAlertController(title: "Missing Photo", message: "Must select a new photo before updating existing Player photo", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    return
                    
                    
                }  // if missing photo alert

                
                // Create new Alert
                
                let dialogMessage = UIAlertController(title: "Player already has Photo", message: "Do you want to replace the current Player's Photo?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { [self] (action) -> Void in
                   // print("Ok button tapped")
                   // Add code to replace Player's Photo
                   // self.pickerController.sourceType = .photoLibrary
                   // present(pickerController, animated: true, completion: nil)
                    
                    
                    if let image = PlayerPhoto.image {
                        
                    PlayerPhoto.image = image
                    
                    
                    let asset = CKAsset(fileURL: saveImageToFile(image))
                   
                    
                  // let name = teamName.text!
                    let playerName = Player.text!
                   let scoreDate = Date()
                    
                    // Get CKRecordID for team and player in team DB
                    //Assign to playerID
                    
                    let playerRecord = playerSearch.queryPlayer(pName: playerName, team: name)
                    
                    playerID = playerRecord.playID
                    print("playerID for photo: ", playerID)
                    
                    
                       
                    // This code works
                    CKContainer.default().publicCloudDatabase.fetch(withRecordID: playerID) { (record, error) in

                    if let recordToSave =  record {
                    
                                           
                        recordToSave["playerPhoto"] = asset
                        recordToSave["LastDate"] = scoreDate
                        
                        
                        // This code does save the image
                        print("recordToSave before save: ", recordToSave)
                        
                        let operation = CKModifyRecordsOperation(recordsToSave: [recordToSave], recordIDsToDelete: nil)
                       // print("operation for save photo: ", operation)
                        
                        
                   operation.savePolicy = CKModifyRecordsOperation.RecordSavePolicy.changedKeys
                    
                    
                    operation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
                            if error == nil {
                                print("Modified Record with photo")
                                
                                
                            } else {
                                print("error in saving photo record")
                                
                           
                        } // if error
                     } // completionblock
                    
                   
                   CKContainer.default().publicCloudDatabase.add(operation)
                    
                       
                        
                    } // Record to save
                    }  // Fetch
                        
                      //  print("record before save: ", record)
                     
                    // Code above to save photo in Cloudkit
            
                    }  //if image
                    
                    // Create new Alert
                     let dialogMessage = UIAlertController(title: "Player photo updated", message: "Photo for player successfully updated", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                        
                        
                        
                      }) // OK UIAlertAction
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    
                    
                    
                    
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
               
                
            }  // if photoCheck count
            
            
            
            } //if photoCheck
            
        /*
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        */

        
        
        
    }  // selectPhoto
    
    
    
    @IBAction func LibraryPhoto(_ sender: Any) {
    
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
        
    
    }  // LibraryPhoto
    
    
    
    
    
    // Use phone camera to capture photo
    @IBAction func CameraPhoto(_ sender: Any) {
        
         pickerController.sourceType = .camera
         present(pickerController, animated: true, completion: nil)

        
    }  // CameraPhoto
    
    
    
    
    
        
    //Save image to file
    func saveImageToFile(_ image: UIImage) -> URL
    {
        let filemgr = FileManager.default

        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)

        let fileURL = dirPaths[0].appendingPathComponent("currentImage.jpg")

        print("fileURL: ", fileURL)
        
        if let renderedJPEGData =
            image.jpegData(compressionQuality: 0.5) {
            try! renderedJPEGData.write(to: fileURL)
        }  //if renderedJPEGData

        return fileURL
        
    }  //saveImageToFile
   
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if let image = info[.originalImage] as? UIImage {
            
            PlayerPhoto.image = image
            
            /*
            let asset = CKAsset(fileURL: saveImageToFile(image))
           
            
          // let name = teamName.text!
            let playerName = Player.text!
           let scoreDate = Date()
            
            // Get CKRecordID for team and player in team DB
            //Assign to playerID
            
            let playerRecord = playerSearch.queryPlayer(pName: playerName, team: name)
            
            playerID = playerRecord.playID
            print("playerID for photo: ", playerID)
            
            /*
            let attempts = playerRecord.totalAttempts
            print("total attempts: ", attempts)
             
            let totalMakes = playerRecord.totalMakes
            print("total makes: ", totalMakes)
            
            let shotPer =  Double (Double(totalMakes) / Double(attempts))
            
            let shotPercentage = Double(round(shotPer*1000)/1000)
            print("shotPercentage: ", shotPercentage)
            */
            
            // Fetch record with CKRecordID
            /*
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: playerID) { (record, error) in
                
                guard let record = record, error == nil else {
                    
                    print("Error in fetching record")
                    
                    return
                }  // else
               
                print("Record in fetch for Photo: \(record)")
              */
            
                //Save photo for CKRecordID in team DB
                
             //   playerRecord["player"] = playerName
                
              //  print("player name in playerRecord: ", playerName)
                
            
               
            // This code works
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: playerID) { (record, error) in

            if let recordToSave =  record {
            
            
            //  let record = CKRecord(recordType: "team")
           // let teamRecord = playerID.recordName
            
           // record["Name"] = teamRecord
            
             //  record.setParent(playerID)
            
             //  record.setObject(asset, forKey: "playerPhoto")
            
              //record["recordName"] = playerID as? __CKRecordObjCValue
            
              // record["teamName"] = name
              // record["player"] = playerName
              //  record["TotAttempts"] = attempts
              //  print("TotAttempts in photoUpdate: ", attempts)
                    
              //  record["TotMakes"] = totalMakes
                    
              //  record["TotPercentage"] = shotPercentage
            
              //   record["LastDate"] = scoreDate
        
               // record["playerPhoto"] = asset
            
               // recordToSave.setObject(asset, forKey: "playerPhoto")
               // recordToSave.setObject(playerID, forKey: "recordName")
                
                recordToSave["playerPhoto"] = asset
                recordToSave["LastDate"] = scoreDate
                
                
                // recordToSave.setObject(scoreDate, forKey: "LastDate")
                
                // This code does save the image
                print("recordToSave before save: ", recordToSave)
                
                let operation = CKModifyRecordsOperation(recordsToSave: [recordToSave], recordIDsToDelete: nil)
               // print("operation for save photo: ", operation)
                
                
           operation.savePolicy = CKModifyRecordsOperation.RecordSavePolicy.changedKeys
            
            
            operation.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
                    if error == nil {
                        print("Modified Record with photo")
                        
                        
                    } else {
                        print("error in saving photo record")
                        
                   
                } // if error
             } // completionblock
            
           
           CKContainer.default().publicCloudDatabase.add(operation)
            
               
                
            } // Record to save
            }  // Fetch
                
              //  print("record before save: ", record)
             */
            // Code above to save photo in Cloudkit
    
        }  // if image
        
        pickerController.dismiss(animated: true, completion: nil)
       
        /*
        // Create new Alert
         let dialogMessage = UIAlertController(title: "Player photo selected", message: "Photo selected for player", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
            
            //Update tableView? - Doesn't fire
            /*
            self.teamTableViewTableViewController?.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
            */
            
          }) // OK UIAlertAction
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)

        */
        
       // self.performSegue(withIdentifier: "backToTableView", sender: self)
        
    } // imagePickerController
    
  
    
    
    
    @IBAction func DeletePlayer(_ sender: Any) {
        
       tName = name
       // print("tName: ", tName)
        
        let pName = Player.text!
       // print("pName: ", pName)
        
        // Don't need to check for team name
        /*
        if tName == "" {
            
            // Create Alert for Team
             let dialogMessage = UIAlertController(title: "Missing Team", message: "Must enter Team and Player", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
            
        } else {
         */
            if pName == "" {
               
                // Create Player Alert
                 let dialogMessage = UIAlertController(title: "Missing Player", message: "Must Player", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            } // if pName
            
      //  } // if tName

        // Add check if team already exists
        
        let playerVerify = teamPlayerCheck.TeamPlayer(team: name, player: pName)
    
        if playerVerify.count == 0 {
            
            
            let dialogMessage = UIAlertController(title: "Player not found", message: "Re-enter correct Player name", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
               // print("Ok button tapped")
                
              //  self.performSegue(withIdentifier: "teamPasser", sender: self)
                return

            })  // UIAlertAction ok
            
            dialogMessage.addAction(ok)
           
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)

        } //if playerVerify check
        
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this player?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
           // print("Ok button tapped")
            self.deleteRecord()
            
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
        
    }  // deletePlayer
    
    func deleteRecord()
    {
        print("Delete record function called")
        
        // print("teamName in delete:  \teamName")
        
        // print("playerNames in delete:   \playerNames")
       //  let teamN = teamName.text!
         
         let playerN = Player.text!
         
        print("tName in delete: ", tName)
         
         let recordTeam = playerSearch.queryPlayer(pName: playerN, team: tName)
        
        
         
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

         var textMessDelete = Player.text!
         
         textMessDelete.append(" removed from ")
         
         textMessDelete.append(tName)
         
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
        
    } // DeletePlayer

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "BacktoRosterview" {
          //  if segue.destination is PlayerManagement {
                    print("BacktoRosterview Segue")
             
               
                    let vcRoster = segue.destination as! UINavigationController
                   
                    let vcScore = vcRoster.viewControllers.first as! RosterViewController
                    
                   
              //  vcScore.title = self.team
                vcScore.name = self.name
            
                print("vcScore.team ", vcScore.name)
            
        } // if segue to RosterviewController
            
        } // prepare func

    
    
    
    
    

}  // PlayerManagement Class
