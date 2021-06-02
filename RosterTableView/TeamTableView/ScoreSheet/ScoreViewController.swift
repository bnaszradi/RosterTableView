//
//  ScoreViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/10/21.
//

import Foundation
import UIKit
import CloudKit

class ScoreViewController: UIViewController {
    
    
    let playerSearch = PlayerTeamData()
    
    let teamSearch = UpdateTeamTotals()
    
    var team: String = ""
    
    var playerN: String = ""
   
    var playerID: CKRecord.ID = CKRecord.ID()
    
   // var scoreDate: Date
   
   
    var playerMake: Int = 0
    var totalMakes: Int = 0
    
    var playerMiss: Int = 0
    
    var nomAttempts: Int = 0
    var attempts: Int = 0
    
    var shotPercent: Double = 0.000
    var sPercentage: Double = 0.000
   
   let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
 // let score = ScoreDataLoader (pName: playerPicked, sType: shotType, attempts: nomAttempts, percent: shotPercent)
    

    @IBOutlet weak var playerPicked: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        playerPicked.text = playerN
        
        // Add query for playerN and team of team record type to retrieve playerPhoto
      
      let playerPicture = TeamPlayerCheck()
        
        let photo = playerPicture.playerPhoto(team: team, player: playerN)
       // print("photo, TotAttempts: ", photo)
        
       // print("photo 0 in array: ", photo[0])
        
        //Add code to display playerPhoto
        
        if photo.isEmpty {
            
            photoPlayer.image = nil
            
        } else {
            
        let photoPic = photo[0]
       // print("photoPic: ", photoPic)
       
        let imageData = NSData(contentsOf: photoPic.fileURL!)
       // print("imageData: ", imageData as Any)
        
        let image = UIImage(data: imageData! as Data)
        
        photoPlayer.image = image
        
        }  // if else
        
        
        
    }  //viewDidLoad
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  //touchesBegan
    
    
    @IBOutlet var photoPlayer: UIImageView!
    
    @IBOutlet weak var makeScore: UILabel!
    
    
    @IBOutlet weak var missScore: UILabel!
    
    
    @IBAction func makeButton(_ sender: Any) {
        
            playerMake += 1
            makeScore.text = String(playerMake)
            messageLabel.text = "Great Shot!"
            
  
    }  // makeButton
    
    
    
    @IBAction func makeStepper(_ sender: Any) {
    
       // let stepperValue: Int = 0
       // playerMake += 1
       // makeScore.text = String(playerMake)
        messageLabel.text = "Great Shot!"
        
        makeStepper(makeScore ?? 00)
        //makeScore.text = String(makeStepper(stepperValue))
        
        
    } // makeStepper
    
    
    
    
    @IBAction func missButton(_ sender: Any) {
        playerMiss += 1
        missScore.text = String(playerMiss)
        
        messageLabel.text = "Try again!"
        
    }  //  missButton
    
    
    
    @IBAction func missStepper(_ sender: Any) {
    
    } // missStepper
    
    
    
    
    @IBOutlet weak var messageLabel: UILabel!
    

    
    @IBAction func submitButton(_ sender: Any) {
        
            messageLabel.text = ""
        
            let nomAttempts = playerMake + playerMiss
            
       //     print("nomAttempts: ", nomAttempts)
         
        let scoreDate = Date()
      //  print("scoreDate: ", scoreDate)
      
      //  print("playerMake: ", playerMake)
        
        let shotP =  Double (Double(playerMake) / Double(nomAttempts))
        
        let shotPercent = Double(round(shotP*1000)/1000)
    
       // print("shotPercent: ", shotPercent)
        
        

        let recordPlayer = CKRecord(recordType: "playername")
        
        
        // Need to query the team type to get this record for teamName and player
        
        let recordTeam = playerSearch.queryPlayer(pName: playerN, team: team)
        
        /*
        let recordTeam = CKRecord(recordType: "team")
        let recordTeamID = recordTeam.recordID
        
       recordTeam["teamName"] = team
       recordTeam["player"] = playerPicked.text
       */
        
        
      //  let recordTeamID = recordTeam.recordID
        
       // print("teamName: ", team)
       // print("player: ", playerPicked.text!)
       // print("recordTeamID in ScoreViewController: ", recordTeamID)
        
       print("recordTeam in ScoreViewController: ", recordTeam)
        
        // recordTeamID doesn't work with recordPlayer CKRecord.Reference below
        //let recordTeamID = recordTeam.recordID
       
        // establish reference between record types
        recordPlayer["teamReference"] = CKRecord.Reference(record: recordTeam, action: .deleteSelf)
                
                
        recordPlayer["player"] = playerPicked.text
        
        recordPlayer["shotAttempts"] = Int(nomAttempts)
        
        recordPlayer["shotMakes"] = Int(playerMake)
        
        recordPlayer["date"] = scoreDate
        
        recordPlayer["shotPercentage"] = Double(shotPercent)
        
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
       

        
        let recordTotals = teamSearch.queryPlayer(pName: playerN, team: team)
        print("recordTotals: ", recordTotals)
        
        playerID = recordTotals.playID
        print("playerID: ", playerID)
        
        attempts = recordTotals.totalAttempts
        print("total attempts: ", attempts)
        let totAttempts = attempts + nomAttempts
        print("totAttempts: ", totAttempts)
        
        
        totalMakes = recordTotals.totalMakes
        print("total makes: ", totalMakes)
        let totMakes = totalMakes + playerMake
        print("totMakes: ", totMakes)
        
        let shotPer =  Double (Double(totMakes) / Double(totAttempts))
        
        let shotPercentage = Double(round(shotPer*1000)/1000)
        print("shotPercentage: ", shotPercentage)
       
        
        let updateTeam: () = teamSearch.totalsUpdate(playerID: playerID, teamName: team, pName: playerN, attempts: totAttempts, totalMakes: totMakes, shotPercentage: shotPercentage, scoreDate: scoreDate)
        
        print("recordTeam: ", updateTeam)
         
        
        
      //  messageLabel.text = "Score recorded"
        
        var textScoreAdded = playerPicked.text!
        
        textScoreAdded.append(" score recorded")
        
       // textScoreAdded.append(teamName.text!)
        
       print("textScoreAdded: ", textScoreAdded)
           
        let dialogMessage = UIAlertController(title: "Score Recorded", message: textScoreAdded, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)


    }  //submitButton
    
    
    @IBAction func resetButton(_ sender: Any) {
        
        messageLabel.text = "Reset Scoreboard to 00 - 00"
        
        playerMake = 0
        playerMiss = 0
        makeScore.text = String("00")
        missScore.text = String("00")
        
    }  //resetButton
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "BacktoRosterview" {
          //  if segue.destination is PlayerManagement {
                    print("BacktoRosterview Segue")
             
               
                    let vcRoster = segue.destination as! UINavigationController
                   
                    let vcScore = vcRoster.viewControllers.first as! RosterViewController
                    
                   
              //  vcScore.title = self.team
                vcScore.name = self.team
            
                print("vcScore.team ", vcScore.name)
            
        } // if segue to RosterviewController
            
        } // prepare func

    
    
    

}  //Class ScoreViewController
