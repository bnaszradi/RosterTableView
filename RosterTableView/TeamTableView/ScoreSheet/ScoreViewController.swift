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
    
    
    //let playerSearch = PlayerTeamData()
    let playerTeamData = PlayerTeamData()
    
    //let teamSearch = UpdateTeamTotals()
    let updateTeamTotals = UpdateTeamTotals()
    
    let eventTeamCheck = EventTeamCheck()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
    let teamPlayerCheck = TeamPlayerCheck()
    
    var team: String = ""
    
    var eventN: String = ""
    
    var eventDate: Date = Date()
    
    var playerN: String = ""
    
    var scoreboardVariable: Bool = false
   
    var playerID: CKRecord.ID = CKRecord.ID()
    
    var playerMake: Int = 0
    var playerMiss: Int = 0
    var eMake: String = ""
    var eMiss: String = ""
    
    var yesScore: Int = 0
    var noScore: Int = 0
    
    var totalMakes: Int = 0
    
    
    var nomAttempts: Int = 0
    var attempts: Int = 0
    
    var shotPercent: Double = 0.000
    var sPercentage: Double = 0.000
    
    var eventSwitch: Bool = false
    
    var recordTeam = CKRecord(recordType: "team")

    
    let dispatchGroup = DispatchGroup()
    
   
   let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    @IBOutlet weak var playerPicked: UILabel!
    
    
    let myActivityIndicator = UIActivityIndicatorView(style: .large)
        

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Display text in UILabels from segues
        playerPicked.text = playerN
        FundEventName.text = eventN
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        //dateFormatter.timeStyle = .short
        
        print("eventDate in viewDidLoad ScoreviewController: ", eventDate)
        FundEventDate.text = dateFormatter.string(from: eventDate)
        
        //Update event score
        print("eMake in ViewDidLoad ScoreViewController: ", eMake)
        tMake.text = eMake
        
        print("eMiss in ViewDidLoad ScoreViewController: ", eMiss)
        tMiss.text = eMiss
        
        
        // Add query for playerN and team of team record type to retrieve playerPhoto
        // Need to fix this query
        
      //  let photo = teamPlayerCheck.playerPhoto(team: team, player: playerN)
         
        print("team in viewDidLoad ScoreViewController: ", team)
        print("playerN in viewDidLoad ScoreViewController: ", playerN)
        
         teamPlayerCheck.playerPhoto(team: team, player: playerN, completion:  { qPlayerArrayPhoto in
             
             DispatchQueue.main.async {
                 
       
        //Code to display playerPhoto
        
      //  if photo.isEmpty {
                 
            let image = qPlayerArrayPhoto.playerArray
                 
                 if image.isEmpty {
            
                     self.photoPlayer.image = nil
                     print("photoPlayer in viewDidLoad ScoreViewController is nil")
            
                 } else {
            
                     //let photoPic = photo[0]
                   let photoPic = image[0]
                     print("photPic image[0]: ",  image[0])
       
        let imageData = NSData(contentsOf: photoPic.fileURL!)
       
        let image = UIImage(data: imageData! as Data)
        
            self.photoPlayer.image = image
        
                  }  // if image isNmpty else
    
        } // DispatchQueue
       
         } ) // Completionhandler teamPlayerCheck.playerPhoto
        
        
        if eventSwitch == false {
        
        //Retrieve scores from team DB
      //  let recordTotals = self.updateTeamTotals.queryPlayer(pName: self.playerN, team: self.team)
            
            
        updateTeamTotals.queryPlayer(pName: self.playerN, team: self.team, completion: { qResults in
                
            DispatchQueue.main.async {
                          
        
                // let totalAtt = recordTotals.totalAttempts
                let totalAtt = qResults.totalAttempts
                                 
                          
                // let totalMis = totalAtt - recordTotals.totalMakes
                let totalMis = totalAtt - qResults.totalMakes
        
                // Update scoreboard for totalMake and totalMiss
                // tMake.text = String(recordTotals.totalMakes)
                self.tMake.text = String(qResults.totalMakes)
                          
                self.tMiss.text = String(totalMis)
        
                } //DispatchQueue
                 
              } ) //Completionhandler updateTeamTotalsqueryPlayer
            
                          
        }  // if eventSwitch = false
        
    }  //viewDidLoad
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  //touchesBegan
    
    
    @IBOutlet var photoPlayer: UIImageView!
    
    @IBOutlet weak var makeScore: UILabel!
    
    @IBOutlet weak var missScore: UILabel!
    
    @IBAction func makeStepper(_ sender: UIStepper) {
        
        yesScore = Int(sender.value)
        makeScore.text = String(yesScore)
        playerMake = Int(sender.value)
       // print("playerMake Stepper: ", playerMake)
        
    }  // makeStepper
    
    
    @IBAction func missStepper(_ sender: UIStepper) {
        
        noScore = Int(sender.value)
        missScore.text = String(noScore)
        playerMiss = Int(sender.value)
        
    }  // missStepper
    
    
    @IBOutlet weak var tMake: UILabel!
    
    @IBOutlet weak var tMiss: UILabel!
    
    @IBAction func submitButton(_ sender: Any) {
   
        print("Submit Button selected")
        
        // Show that activity spinner
        self.showSpinner()
        print("spinner started")
        
        dispatchGroup.notify(queue: .main) { [self] in
            
            self.dispatchGroup.enter()
            
            let nomAttempts = self.playerMake + self.playerMiss
            
          print("nomAttempts: ", nomAttempts)
         
        let scoreDate = Date()
      //  print("scoreDate: ", scoreDate)
      
      //  print("playerMake: ", playerMake)
        
        let shotP =  Double (Double(self.playerMake) / Double(nomAttempts))
        
        // print("shotP: ", shotP)
        
        
        let shotPercent = Double(round(shotP*1000)/1000) * 100
    
       // print("shotPercent: ", shotPercent)
        
        let recordPlayer = CKRecord(recordType: "playername")
        
        // Query the team type to get this record for teamName and player
        
     //       let recordTeam = self.playerTeamData.queryPlayer(pName: self.playerN, team: self.team)
        
            playerTeamData.queryPlayer(pName: self.playerN, team: self.team, completion: { qResults in
                
            DispatchQueue.main.async {
                    
                    recordTeam = qResults.playerRecord
                    
                    print("recordTeam in ScoreViewController: ", recordTeam)
        
                    // establish reference between record types
                recordPlayer["teamReference"] = CKRecord.Reference(record: recordTeam, action: .deleteSelf)
                
            //Check if event is chosen and if chosen create a reference to event type for event
            print("eventSwitch value: ", eventSwitch)
                
            if eventSwitch == true {
                
            //    let recordEvent = self.eventTeamCheck.querySingleEvent(team: team, eventD: eventDate)
                
                eventTeamCheck.querySingleEvent(team: self.team, eventD: self.eventDate, completion: { qSingleEvent in
                    
                    DispatchQueue.main.async {
                     
                    let recordResults = qSingleEvent.recordResults
                        
                  print("recordResults in ScoreViewController: ", recordResults)
                
                  recordPlayer["eventReference"] = CKRecord.Reference(record: recordResults, action: .deleteSelf)
                
                    recordPlayer["player"] = self.playerPicked.text
                        
                    recordPlayer["shotAttempts"] = Int(nomAttempts)
                        
                    recordPlayer["shotMakes"] = Int(self.playerMake)
                        
                    recordPlayer["date"] = scoreDate
                        
                    recordPlayer["shotPercentage"] = Double(shotPercent)
                        
                                    
                        print("recordPlayer before save: ", recordPlayer)
                                    
                    CKContainer.default().publicCloudDatabase.save(recordPlayer) { record, error in
                                DispatchQueue.main.async {
                                   if error == nil {
                                        
                                    } else {
                                       let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                                       ac.addAction(UIAlertAction(title: "OK", style: .default))
                                      
                                    }  // else
                                    
                              } //if error
                             } // DispatchQueue
                        
                    } // DispatchQueue
                }) // Completionhandler eventTeamCheck.querySingleEvent
                        
                        
            }  else { //if eventSwitch is not true
          
       
        recordPlayer["player"] = self.playerPicked.text
        
        recordPlayer["shotAttempts"] = Int(nomAttempts)
        
        recordPlayer["shotMakes"] = Int(self.playerMake)
        
        recordPlayer["date"] = scoreDate
        
        recordPlayer["shotPercentage"] = Double(shotPercent)
        
                    
        print("recordPlayer before save: ", recordPlayer)
                    
        CKContainer.default().publicCloudDatabase.save(recordPlayer) { record, error in
                DispatchQueue.main.async {
                   if error == nil {
                        
                    } else {
                       let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                       ac.addAction(UIAlertAction(title: "OK", style: .default))
                      
                    }  // else
                    
              } //if error
             } // DispatchQueue
            } // else
                
                } //DispatchQueue for completionhandler
                
            })  // playerTeamData.queryPlayer completionhandler
                    
            
        // Fetch player record in team DB and update with score for all shots
            
       // let recordTotals = self.updateTeamTotals.queryPlayer(pName: self.playerN, team: self.team)
       // print("recordTotals: ", recordTotals)
            
            
        updateTeamTotals.queryPlayer(pName: self.playerN, team: self.team, completion: { qResults in
                
            DispatchQueue.main.async {
                        
            
      //  playerID = recordTotals.playID
        playerID = qResults.playID
        print("playerID: ", self.playerID)
        
      //  attempts = recordTotals.totalAttempts
        attempts = qResults.totalAttempts
        print("total attempts: ", attempts)
                          
        let totAttempts = attempts + nomAttempts
        print("totAttempts: ", totAttempts)
        
       // totalMakes = recordTotals.totalMakes
        totalMakes = qResults.totalMakes
        print("total makes: ", totalMakes)
        let totMakes = totalMakes + playerMake
        print("totMakes: ", totMakes)
        
        
        // Update scoreboard for totalMake and totalMiss
            tMake.text = String(totMakes)
            let missTot = totAttempts - totMakes
            tMiss.text = String(missTot)
        
            
        let shotPer =  Double (Double(totMakes) / Double(totAttempts))
        
        let shotPercentage = Double(round(shotPer*1000)/1000) * 100
        print("shotPercentage: ", shotPercentage)
       

        // Update team DB with totals
        updateTeamTotals.totalsUpdate(playerID: playerID, teamName: team, pName: playerN, attempts: totAttempts, totalMakes: totMakes, shotPercentage: shotPercentage, scoreDate: scoreDate)
        
                          
                      } //DispatchQueue
                 
              }  //Completionhandler
                
            ) //updateTeamTotals.queryPlayer

    
        // Check if event has been chosen. If event chosen, update the donations table
        
            //If event selected
    print("eventSwitch check in Submit button: ", eventSwitch)
            
            if eventSwitch == true {
                
       //     let donationCheckRecord = updateDonationsTotals.queryCheckSponsor(tName: team, pName: playerN, eDate: eventDate)
            
            updateDonationsTotals.queryCheckSponsor(tName: team, pName: playerN, eDate: eventDate, completion: { qCheckSpons in
                
                print("Started updateDonationsTotals.queryCheckSponsor ")
                
                DispatchQueue.main.async {
                   
            //If donation record for team, player, eventDate doesn't exist, create it
                    
            let donationCheckRecord = qCheckSpons.playerArray
                
            print("donationCheckRecord.count: ", donationCheckRecord.count)
                    
            if donationCheckRecord.count == 0 {
               
               // let tAttempts: Int = 0
                let tAttempts: Int = nomAttempts
              //  let tMakes: Int = 0
                let tMakes: Int = playerMake
                let tPerShot: Double = 0.0
              //  let tPerShot: Double = shotPercent
                let tFlatDonation: Double = 0.0
                let tDonation: Double = 0.0
                
                
                playerTeamData.queryPlayer(pName: self.playerN, team: self.team, completion: { qResults in
                    
                DispatchQueue.main.async {
                        
                let recordPlay = qResults.playerRecord
                        
                    print("recordPlay in ScoreViewController: ", recordPlay)
            
                        // establish reference between record types
                //     recordPlayer["teamReference"] = CKRecord.Reference(record: recordPlay, action: .deleteSelf)
                
               
                
         //  updateDonationsTotals.createDonationRecord(teamName: team, pName: playerN, eDate: eventDate, totAttempts: tAttempts, totMakes: tMakes, totPerShot: tPerShot, totFlatDonation: tFlatDonation, totalDonation: tDonation, eventName: eventN)
             
            updateDonationsTotals.createDonationRecord(teamName: team, pName: playerN, eDate: eventDate, totAttempts: tAttempts, totMakes: tMakes, totPerShot: tPerShot, totFlatDonation: tFlatDonation, totalDonation: tDonation, eventName: eventN, recordPlayer: recordPlay)
                    
                } //dispatchQueue
                } )  // completionhanlder playerTeamData.queryPlayer
                
                

              }  // above - if donation record doesn't exist create it
            
        // Query donations for team, player, eventDate and retrieve totAttampts, totMakes, totFlatDonation, totPerShot, totalDonation values
        
      //  let donationValues = updateDonationsTotals.querySponsorWithShots(tName: team, pName: playerN, eDate: eventDate)
          
            updateDonationsTotals.querySponsorWithShots(tName: team, pName: playerN, eDate: eventDate, completion: { qSponsorWithShots in
                                                    
            DispatchQueue.main.async {
             
            let donationValues = qSponsorWithShots
                
            let recordID = donationValues.sponsorID
            let totalAttempt = donationValues.totAttempt
            let totalMake = donationValues.totMake
            let totalFlatDonation = donationValues.totFlatDon
            let totalPerShot = donationValues.totPerShot
         //   let totalDonations = donationValues.totalDonation
        
        //Perform calculations to donation values to update based upon shots
        
            let attemptTotal = totalAttempt + nomAttempts
            
            let makesTotal = totalMake + playerMake
            
            let perShotTot = totalPerShot * Double(makesTotal)
            
            let donationsTotal = perShotTot + totalFlatDonation
            
            // Update scoreboard with event total Make and Miss
        
            tMake.text = String(makesTotal)
            let missTotal = attemptTotal - makesTotal
            tMiss.text = String(missTotal)
            
            
        //Update donations values with calculated values
        
        updateDonationsTotals.totalsUpdateWithShots(sponsorID: recordID, teamName: team, pName: playerN, totalAttempt: attemptTotal, totalMake: makesTotal, totalPerShot: totalPerShot, totalFlatDonation: totalFlatDonation, totalDonation: donationsTotal)
        
            } // DispatchQuue for completionhandler
           
            } ) // completionhandler updateDonationsTotals.querySponsorWithShots
                
            } // DispatchQueue for completionhandler
                
            })  // Completionhandler updateDonationsTotals.queryCheckSponsor
                    
                    
         }  // if  event chosen
            
            
        var textScoreAdded = playerPicked.text!
        
        textScoreAdded.append(" score recorded")
        
        
       print("textScoreAdded: ", textScoreAdded)
           
        let dialogMessage = UIAlertController(title: "Score Recorded", message: textScoreAdded, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            
            self.dispatchGroup.leave()
            self.removeSpinner()
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)


        
        //  Insert stop activity animation here
       // self.removeSpinner()
        
        } // dispatchGroup.notify
     
        
        
     
        
        
    }  //submitButton
    
   
    @IBOutlet weak var FundEventName: UITextField!
    
    
    @IBOutlet weak var FundEventDate: UILabel!
    
    
    // Event button to query and select an event for the team selected
    
    @IBAction func EventButton(_ sender: UIButton) {
        
      //  eventSwitch = true
      //  print("eventSwitch value after EventButton: ", eventSwitch)
        print("toEventsList segue from EventButton")
        
        performSegue(withIdentifier: "toEventsList", sender: self)
        
    } // EventButton
    
    
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
            
            
            
            if segue.identifier == "toEventsList" {
                
                print("toEventsList Segue")
         
           
                let vc = segue.destination as! UINavigationController
               
                let vcEvents = vc.viewControllers.first as! EventsCollectionViewController
                
                
            let scoreboardVar: Bool = true
            
            vcEvents.title = self.team
            vcEvents.team = self.team
            vcEvents.playerN = self.playerN
            vcEvents.scoreboardVariable = scoreboardVar
        
            print("vcEvents.team in toEvents segue: ", vcEvents.team)

                
            } // toEventsList
            
        
        } // prepare func

    
    
    

}  //Class ScoreViewController
