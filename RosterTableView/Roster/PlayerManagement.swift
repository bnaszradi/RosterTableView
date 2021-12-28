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

    var name: String = ""
    
    var playerName: String = ""
    
    var pName: String = ""
    var tName: String = ""
    
    //var playerArray = [] as Array<String>
    
    let teamPlayerCheck = TeamPlayerCheck()
    
    let updateTeamTotals = UpdateTeamTotals()
 
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
            
     
        // Add check to determine if an extra blamk space was added to the team name when entered by user. If so, remove the blank character(s)
        
        var playerArray = Array(pName)
        
        print("playerArray: ", playerArray)
        
       var playerNumChar = playerArray.count
       print("playerNumChar: ", playerNumChar)
        
       var extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
        
        while playerArray[extraPlayerCharLessOne] == " " {
            
            playerArray.remove(at: extraPlayerCharLessOne)
            print("playerArray after remove end blank character: ", playerArray)
            
           playerNumChar = playerArray.count
           print("playerNumChar: ", playerNumChar)
            
        extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
            
        } // if teamArray
        
        pName = String(playerArray)
        
        print("pName after parsing blank characters from end: ", pName)
    
       // Check if player already exists on roster
        
        teamPlayerCheck.teamPlayer(team: tName, player: pName, completion: {
            qPlayerArray in
            
            DispatchQueue.main.async {
                
                let check = qPlayerArray.playerArray.count
                
                print("qPlayerArray check: ", check)
                
        
       
        if check > 0 {
          
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
          
            return
            
        } // if check.count
            
            
     //   }  else {
        
            if self.PlayerPhoto.image == nil {
                
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
            
            if let image = self.PlayerPhoto.image {
            
                let asset = CKAsset(fileURL: self.saveImageToFile(image))
            
                recordPlayer["player"] = self.pName
    
                recordPlayer["teamName"] = self.tName
        
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
       
            
                var textDisplay = self.pName
        
        textDisplay.append(" added to ")
        
                textDisplay.append(self.tName)
        
       print("textDisplay: ", textDisplay)
        
            let dialogMessage = UIAlertController(title: "Player Added", message: textDisplay, preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                  })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)

            
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            
       
        
        } // if image
        
      
            }  // DispatchQueue
                                 
            } ) // teamPlayerCheck.teamPlayer
                     
                
                
                
                
    } // AddPlayer
    
    
    

    // Update photo
    @IBAction func AddPhoto(_ sender: Any) {
        
        // Check to see if a photo is selected to update
        if self.PlayerPhoto.image == nil {
                
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
            
        // Add check to determine if an extra blamk space was added to the team name when entered by user. If so, remove the blank character(s)
        
        var playerArray = Array(pName)
        
        print("playerArray: ", playerArray)
        
       var playerNumChar = playerArray.count
       print("playerNumChar: ", playerNumChar)
        
       var extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
        
        while playerArray[extraPlayerCharLessOne] == " " {
            
            playerArray.remove(at: extraPlayerCharLessOne)
            print("playerArray after remove end blank character: ", playerArray)
            
           playerNumChar = playerArray.count
           print("playerNumChar: ", playerNumChar)
            
        extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
            
        } // while playerArray
        
        pName = String(playerArray)
        
        print("pName after parsing blank characters from end: ", pName)
    
    // Check if player (and photo) for team exists
    
        teamPlayerCheck.teamPlayer(team: tName, player: pName, completion: {
            qPlayerArray in
            
        DispatchQueue.main.async {
        
        let check = qPlayerArray.playerArray.count
        
        print("check in AddPhoto: ", check)
        
        if check == 0 {
          
            //Player not on roster yet
            
            // Create new Alert
             let dialogMessage = UIAlertController(title: "Player Not Found", message: "Player not found on Team roster. Add correct Player to this Team then Update Photo", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
          
            return
           //   } // if check == 0
                
    
        }  else {
   
       
                // Create alert to confirm replacement of player photo
                
                let dialogMessage = UIAlertController(title: "Replace existing Player Photo", message: "Do you want to replace the current Player's Photo?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { [self] (action) -> Void in
                    
                    if let image = PlayerPhoto.image {
                        
                    PlayerPhoto.image = image
                    
                    
                    let asset = CKAsset(fileURL: saveImageToFile(image))
                   
                    
                  // let name = teamName.text!
                 //   let playerName = pName
                     let scoreDate = Date()
                    
                    // Get CKRecordID for team and player in team DB
                    //Assign to playerID
                    
                  
                updateTeamTotals.queryPlayer(pName: pName, team: name, completion: { qResults in
                            
                        DispatchQueue.main.async {
                                      
                                
                        let playerID = qResults.playID
                                  
                        print("playerID in updateTeamTotals.queryPlayer: ", playerID)
                         
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
                     } // modifyRecordsCompletionblock
                    
        
                   CKContainer.default().publicCloudDatabase.add(operation)
                    
                        
                   } // If let Record to save
                   }  // CKContainer Fetch
                        
            
                       
                    
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

                    
                        }  //if image is selected
                    
                    })  // UIAlertAction ok
                
                    } //DispatchQueue
                                                            
                  } ) //Completionhandler updateTeamTotals.queryPlayer
                           
                    
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
            
            } //DispatchQueue
                                                                
          } ) //Completionhandler teamPlayerCheck.teamPlayer
                                                                
                                                     
       
        
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
    
        }  // if image
        
        pickerController.dismiss(animated: true, completion: nil)
       
        
       // self.performSegue(withIdentifier: "backToTableView", sender: self)
        
    } // imagePickerController
    
  
    
    
    
    @IBAction func DeletePlayer(_ sender: Any) {
        
       tName = name
       // print("tName: ", tName)
        
        var pName = Player.text!
        print("pName after delete button pushed: ", pName)
        
        // Check if player name entered
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
            
      
        // Add check to determine if an extra blamk space was added to the player name when entered by user. If so, remove the blank character(s)
        
        var playerArray = Array(pName)
        
        print("playerArray: ", playerArray)
        
       var playerNumChar = playerArray.count
       print("playerNumChar: ", playerNumChar)
        
       var extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
        
        while playerArray[extraPlayerCharLessOne] == " " {
            
            playerArray.remove(at: extraPlayerCharLessOne)
            print("playerArray after remove end blank character: ", playerArray)
            
           playerNumChar = playerArray.count
           print("playerNumChar: ", playerNumChar)
            
        extraPlayerCharLessOne = playerNumChar - 1
        print("extraPlayerCharLessOne: ", extraPlayerCharLessOne)
            
        } // if teamArray
        
        pName = String(playerArray)
        
        print("pName after parsing blank characters from end: ", pName)
    
        
        // Add check if player on team exists
        
     //  let playerVerify = teamPlayerCheck.teamPlayer(team: name, player: pName)
        
        teamPlayerCheck.teamPlayer(team: tName, player: pName, completion: {
            qPlayerArray in
            
        DispatchQueue.main.async {
        
            let playerVerify = qPlayerArray.playerArray
    
        
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
       
        //If player exists present dialog to confirm deletion of player
        let dialogMessage = UIAlertController(title: "Confirm Delete Player", message: "Are you sure you want to delete this player?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
           // print("Ok button tapped")
            print("pName before deleteRecord func callled: ", pName)
            self.deleteRecord(pName: pName)
            
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
        
        }  // DispatchQueue
                
        } ) // teamPlayerCheck.teamPlayer
            
            
            
    }  // deletePlayer
    
            
            
            
            
            
    func deleteRecord(pName: String)
    {
        print("Delete record function called")
        
       print("pName in delete function: ", pName)
        
        print("tName in delete function: ", tName)
         
       //  let recordTeam = playerSearch.queryPlayer(pName: pName, team: tName)
        
       //  playerID = recordTeam.playID
       
        
        updateTeamTotals.queryPlayer(pName: pName, team: tName, completion: { qResults in
            
                  DispatchQueue.main.async {
                      
                
                self.playerID = qResults.playID
                  
                print("playerID: ", self.playerID)
                  
       
                CKContainer.default().publicCloudDatabase.delete(withRecordID: self.playerID) {(recordID, error) in
            
           
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

         var textMessDelete = pName
         
         textMessDelete.append(" removed from ")
         
            textMessDelete.append(self.tName)
         
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
        
                      
            } //DispatchQueue
             
          } ) //Completionhandler updateTeamTotalsqueryPlayer
            
                      
        
    } // DeletePlayer func

    
    
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
