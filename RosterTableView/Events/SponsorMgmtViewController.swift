//
//  SponsorMgmtViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 7/12/21.
//

import UIKit
import CloudKit


extension StringProtocol {
    var double: Double? { Double(self) }
    var float: Float? { Float(self) }
    var integer: Int? { Int(self) }
}


class SponsorMgmtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        eventN.text = eventName
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
      //  dateFormatter.timeStyle = .short
        
        eventD.text = dateFormatter.string(from: eventDate)
        
    } //viewDidLoad
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    var team: String = ""
    var name: String = ""
    var eventName: String = ""
    var eventDate: Date = Date()
    
    let eventRecord = EventTeamCheck()
    
    let playerRecord = PlayerTeamData()
    
    let sponsorRecord = SponsorsList()
    
    var sponsorN: String = ""
    
    let dispatchGroup = DispatchGroup()
    
    let updateDonationsTotals = UpdateDonationsTotals()
    
    var sponsID: CKRecord.ID = CKRecord.ID()
   // var attempts: Int = 0
   // var makes: Int = 0
    var perShotDons: Double = 0.00
    var totShotDons: Double = 0.00
    var flatDons: Double = 0.00
    var totFlatDons: Double = 0.00
   // var donations: Double = 0.0
    
    
    @IBOutlet weak var eventN: UILabel!
    
    
    
    @IBOutlet weak var sponsorName: UITextField!
    
   
    @IBOutlet weak var sponsorPhoneNumber: UITextField!
    
    
    @IBOutlet weak var eventD: UILabel!
    
    
    
    @IBOutlet weak var perShotD: UITextField!
    
    
    @IBOutlet weak var flatD: UITextField!
    
    
    @IBAction func AddSponsor(_ sender: UIButton) {
        
      //  self.showSpinner()
      //  print("spinner started")
        
        
      //  dispatchGroup.notify(queue: .main) { [self] in
         
      //      dispatchGroup.enter()
        
        sponsorN = sponsorName.text!
            
        if sponsorN == "" {
           
            // Create Event Name alert
             let dialogMessage = UIAlertController(title: "Missing Sponsor Name", message: "Must enter a sponsor name", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              // dispatchGroup.leave()
               // removeSpinner()
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
            
        }  //If sponsor Name blank
        
        
        // Add check to determine if an extra blamk space was added to the sponsor name when entered by user. If so, remove the blank character(s)
        
        var sponsorNameArray = Array(sponsorN)
        
        print("teamArray: ", sponsorNameArray)
        
       var sponsorNumChar = sponsorNameArray.count
       print("teamNumChar: ", sponsorNumChar)
        
       var extraSponsorCharLessOne = sponsorNumChar - 1
        print("extraSponsorCharLessOne: ", extraSponsorCharLessOne)
        
        while sponsorNameArray[extraSponsorCharLessOne] == " " {
            
            sponsorNameArray.remove(at: extraSponsorCharLessOne)
            print("sponsorNameArray after remove end blank character: ", sponsorNameArray)
            
           sponsorNumChar = sponsorNameArray.count
           print("sponsorNumChar: ", sponsorNumChar)
            
        extraSponsorCharLessOne = sponsorNumChar - 1
        print("extraSponsorCharLessOne: ", extraSponsorCharLessOne)
            
        } // if teamArray
        
        sponsorN = String(sponsorNameArray)
        
        print("sponsorN after parsing blank characters from end: ", sponsorN)

        
        // check to see if sponsor already exists for the team event
        let checkSponsor = sponsorRecord.sponsorRecordQuery(tName: team, pName: name, eDate: eventDate, sponsorN: sponsorN)
        
        let checkSpons = checkSponsor.sponsorArray
        
        print("checkSponsor count: ", checkSpons.count)
        
        
        if checkSpons.count > 0 {
            
            print("checkSponsor count: ", checkSpons.count)
            
            // Create Event Name alert
             let dialogMessage = UIAlertController(title: "Duplicate Sponsor Name", message: "Must enter a different sponsor name or delete the sponsor name and re-Add the sponsor name.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              //  removeSpinner()
              //  dispatchGroup.leave()
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            
           // removeSpinner()
           // dispatchGroup.leave()
            return

                        
        }  // checkSponsor
       
        
        
        //Check to ensure sponsor phone number entered
        
        var sponsorPhone = sponsorPhoneNumber.text!
            
        if sponsorPhone == "" {
           
            // Create Event Phone Number alert
             let dialogMessage = UIAlertController(title: "Missing Sponsor Phone Number", message: "Must enter a sponsor phone number", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              // dispatchGroup.leave()
               // removeSpinner()
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
            
        }  //If sponsor Phone Number blank
       
        
        
        // Add check to determine if an extra blamk space was added to the sponsor phone number when entered by user. If so, remove the blank character(s)
    
        var sponsorPhoneArray = Array(sponsorPhone)
        
        print("sponsorPhoneArray: ", sponsorPhoneArray)
        
       var sponsorPhoneChar = sponsorPhoneArray.count
       print("sponsorPhoneChar: ", sponsorPhoneChar)
        
       var extraSponsorPhoneLessOne = sponsorPhoneChar - 1
        print("extraSponsorPhoneLessOne: ", extraSponsorPhoneLessOne)
        
        while sponsorPhoneArray[extraSponsorPhoneLessOne] == " " {
            
            sponsorPhoneArray.remove(at: extraSponsorPhoneLessOne)
            print("sponsorNameArray after remove end blank character: ", sponsorNameArray)
            
           sponsorPhoneChar = sponsorPhoneArray.count
           print("sponsorPhoneChar: ", sponsorPhoneChar)
            
        extraSponsorPhoneLessOne = sponsorPhoneChar - 1
        print("extraSponsorPhoneLessOne: ", extraSponsorPhoneLessOne)
            
        } // while sponsorPhoneArray
        
        sponsorPhone = String(sponsorPhoneArray)
        
        print("sponsorPhone after parsing blank characters from end: ", sponsorPhone)

        
        // Verify that sponsor phone number is integers
        
        if let value = sponsorPhone.integer  {
                // Good integer value
               print(value)
                
            } else {
                print("invalid integer input")
            
                // Create Event Date alert
                 let dialogMessage = UIAlertController(title: "Sponsor Phone Number", message: "Must enter a valid sponsor phone number of integers only e.g. 1112223333", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                 //  removeSpinner()
                 //  dispatchGroup.leave()
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
            
                return
              
            } // If Sponsor phone number check is integer
       
        
        // Check if sponsor phone number is 10 digits
        
                if sponsorPhoneArray.count == 10 {
                    // Good phone number
                    print("sponsorPhoneArray.count: ", sponsorPhoneArray.count)
                
            } else {
                print("invalid number count input")
            
                // Create Event Date alert
                 let dialogMessage = UIAlertController(title: "Sponsor Phone Number", message: "Must enter a valid sponsor phone number of ten digits only e.g. 1112223333", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                 //  removeSpinner()
                 //  dispatchGroup.leave()
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)
            
                return
              
            } // If Sponsor phone number check is 10 digits
       
        
    
        // Verify that perShotD value entered
        if perShotD.text == "" {
                
                // Create Event Date alert
                 let dialogMessage = UIAlertController(title: "Missing Donation", message: "Must enter a Per Shot and Flat Donation amounts", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  // removeSpinner()
                  // dispatchGroup.leave()
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

               // removeSpinner()
               // dispatchGroup.leave()
                return
                
            } // Donation per Shot check
                
            // Check if flat donation entered
                if flatD.text == "" {
                    
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Missing Donation", message: "Must enter a Per Shot AND Flat Donation amounts", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                     //  removeSpinner()
                      // dispatchGroup.leave()
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                   // removeSpinner()
                   // dispatchGroup.leave()
                    return
                
            }// flat donation check

        // Verify that perShotD value is a Double

            let perShotV = perShotD.text!
            
                if let value = perShotV.double  {
                    // Good double value
                    print(value)
                } else {
                    print("invalid double input")
                
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Donation per Shot", message: "Must enter a valid number for Donation  amount", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                     //  removeSpinner()
                     //  dispatchGroup.leave()
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)
                    
                   // removeSpinner()
                   // dispatchGroup.leave()
                    return
                    
                } // Donation per Shot check is double value
           
            // Verify that flatD value is a Double

                let flatDV = flatD.text!
                
                    if let value = flatDV.double  {
                        // Good double value
                        print("flatDV value", value)
                    } else {
                        print("invalid double input")
                    
                        // Create Event Date alert
                         let dialogMessage = UIAlertController(title: "Flat Donation", message: "Must enter a valid number for Donation  amount", preferredStyle: .alert)
                         
                         // Create OK button with action handler
                         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                             print("Ok button tapped")
                         //  removeSpinner()
                          // dispatchGroup.leave()
                          })
                         
                         //Add OK button to a dialog message
                         dialogMessage.addAction(ok)

                         // Present Alert to
                         self.present(dialogMessage, animated: true, completion: nil)

                       // removeSpinner()
                       // dispatchGroup.leave()
                        return
                        
                    } // Flat Donation check is double value
            
            
            self.showSpinner()
            print("spinner started")
            
            
            dispatchGroup.notify(queue: .main) { [self] in
             
                dispatchGroup.enter()
            
            
        let recordSponsor = CKRecord(recordType: "sponsor")
        
        
        // Query the event and player to get this record for eventDate and player references
        let eventResults = eventRecord.querySingleEvent(team: team, eventD: eventDate)
        
        let playerResults = playerRecord.queryPlayer(pName: name, team: team)
        
        
        recordSponsor["eventRef"] = CKRecord.Reference(record: eventResults, action: .deleteSelf)
        
        recordSponsor["playerRef"] = CKRecord.Reference(record: playerResults, action: .deleteSelf)
                
        recordSponsor["player"] = name
        
        recordSponsor["sponsorName"] = sponsorN
        
        print("team in add sponsor: ", team)
        
        recordSponsor["team"] = team
        
        recordSponsor["eventDate"] = eventDate
        
        recordSponsor["amountperShot"] = Double(perShotD.text!)
        
        recordSponsor["donation"] = Double(flatD.text!)
                
        recordSponsor["sponsorPhoneNumber"] = Int(sponsorPhone)
        
        CKContainer.default().publicCloudDatabase.save(recordSponsor) { record, error in
                    DispatchQueue.main.async {
                       if error == nil {
                            
                        } else {
                           let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                           ac.addAction(UIAlertAction(title: "OK", style: .default))
                          //  self.persent(ac, animated: true)
                        }  // else
                        
                  } //if error
                 } // DispatchQueue

        
        //If donation record for team, player, eventDate doesn't exist, create it
        
        let donationCheckRecord = updateDonationsTotals.queryCheckSponsor(tName: team, pName: name, eDate: eventDate)
        
        if donationCheckRecord.player.count == 0 {
            let tAttempts: Int = 0
            let tMakes: Int = 0
            let tPerShot: Double = 0.0
            let tFlatDonation: Double = 0.0
            let tDonation: Double = 0.0
            
            
            updateDonationsTotals.createDonationRecord(teamName: team, pName: name, eDate: eventDate, totAttempts: tAttempts, totMakes: tMakes, totPerShot: tPerShot, totFlatDonation: tFlatDonation, totalDonation: tDonation, eventName: eventName)
            
            
        }  // above - if donation record doesn't exist create it
        
        
        //Update donations table to add Total PerShot, Total Flat Donation
        
        
        let donationRecord = updateDonationsTotals.querySponsorWithShots(tName: team, pName: name, eDate: eventDate)
        
        sponsID = donationRecord.sponsorID
        
        perShotDons = donationRecord.totPerShot
        print("perShotDons: ", perShotDons)
        let perShotValue = Double(perShotD.text!)
        totShotDons = perShotDons + perShotValue!
        print("totShotsDons: ", totShotDons)
        
        flatDons = donationRecord.totFlatDon
        print("flatDons: ", flatDons)
        let flatValue = Double(flatD.text!)
        totFlatDons = flatDons + flatValue!
        print("totFlatDons: ", totFlatDons)
        
        let tMakes = donationRecord.totMake
        let donMakes: Double = Double(tMakes) * totShotDons
        print("tMakes: ", tMakes)
        
        let totDonation = donationRecord.totalDonation
        print("totDonation: ", totDonation)
        
        let allDonation = donMakes + totFlatDons
        print("allDonation: ", allDonation)
       
        
        updateDonationsTotals.totalsUpdate(sponsorID: sponsID, teamName: team, pName: name, totalPerShot: totShotDons, totalFlatDonation: totFlatDons, totalDonation: allDonation)
        
          //Update donations table above
        
        
            var textDisplay:String = sponsorName.text!
            
            textDisplay.append(" added for ")
            
            textDisplay.append(name)
            
            textDisplay.append(" sponsor list")
            
           print("textDisplay: ", textDisplay)
                
               
             let dialogMessage = UIAlertController(title: "Sponsor Added for player", message: textDisplay, preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                removeSpinner()
                dispatchGroup.leave()
                print("Ok button tapped")
                
                   })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             
             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
        
            
        }  // dispatchGroup.notify
            
    } //AddSponsor
    
    
    
    @IBAction func deleteSponsor(_ sender: UIButton) {
        
        self.showSpinner()
        print("spinner started")
        
        dispatchGroup.notify(queue: .main) { [self] in
         
       dispatchGroup.enter()
        
        
      sponsorN = sponsorName.text!
            
        // Check that event date is entered
       
        if sponsorN == "" {
                
                 // Create Player Alert
                  let dialogMessage = UIAlertController(title: "Missing Sponsor Name", message: "Must enter Sponsor Name for this player to delete", preferredStyle: .alert)
                  
                  // Create OK button with action handler
                  let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                      print("Ok button tapped")
                   })
                  
                  //Add OK button to a dialog message
                  dialogMessage.addAction(ok)

                  // Present Alert to
                  self.present(dialogMessage, animated: true, completion: nil)

                 removeSpinner()
                 dispatchGroup.leave()
                 return
                 
             } // if sponsorName
             
            
            // Add check to determine if an extra blamk space was added to the sponsor name when entered by user. If so, remove the blank character(s)
            
            var sponsorNameArray = Array(sponsorN)
            
            print("teamArray: ", sponsorNameArray)
            
           var sponsorNumChar = sponsorNameArray.count
           print("teamNumChar: ", sponsorNumChar)
            
           var extraSponsorCharLessOne = sponsorNumChar - 1
            print("extraSponsorCharLessOne: ", extraSponsorCharLessOne)
            
            while sponsorNameArray[extraSponsorCharLessOne] == " " {
                
                sponsorNameArray.remove(at: extraSponsorCharLessOne)
                print("sponsorNameArray after remove end blank character: ", sponsorNameArray)
                
               sponsorNumChar = sponsorNameArray.count
               print("sponsorNumChar: ", sponsorNumChar)
                
            extraSponsorCharLessOne = sponsorNumChar - 1
            print("extraSponsorCharLessOne: ", extraSponsorCharLessOne)
                
            } // if teamArray
            
            sponsorN = String(sponsorNameArray)
            
            print("sponsorN after parsing blank characters from end: ", sponsorN)

         // Add check if sponsor exists
         
         let sponsorVerify = sponsorRecord.sponsorRecordQuery(tName: team, pName: name, eDate: eventDate, sponsorN: sponsorN)
     
       let sponsorVer = sponsorVerify.sponsorArray
        
        print("sponsorVer.count: ", sponsorVer.count)
        
            if sponsorVer.count == 0 {
             
   
             let dialogMessage = UIAlertController(title: "Sponsor not found", message: "Re-enter a valid Sponsor for Player, Team and Event Date.", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
                 removeSpinner()
                 dispatchGroup.leave()
                
               
                 return

             })  // UIAlertAction ok
             
             dialogMessage.addAction(ok)
            
             // Present dialog message to user
             self.present(dialogMessage, animated: true, completion: nil)

         } //if sponsor exists check
         
       
        
         let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this sponsor?", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // print("Ok button tapped")
             self.deleteRecord()
            removeSpinner()
            dispatchGroup.leave()
           
            
         })  // UIAlertAction ok
         
         // Create Cancel button with action handlder
         let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
            removeSpinner()
            dispatchGroup.leave()
           
         } //UIAlertAction cancel
         
         //Add OK and Cancel button to dialog message
         dialogMessage.addAction(ok)
         dialogMessage.addAction(cancel)
         
         // Present dialog message to user
         self.present(dialogMessage, animated: true, completion: nil)
         
       } // Dispatchgroup.Notify
            
     }  // deletePlayer
     
    
    
    // function to delect a sponsor
     func deleteRecord()
     {
         print("Delete record function called")
         
         print("team name in delete: ", team)
          
        // Query sponsor (team, player, event date, sponsor) from sponsor table and return perShot, donation
        
        let getSponsor = sponsorRecord.sponsorRecordQuery(tName: team, pName: name, eDate: eventDate, sponsorN: sponsorN)
        
        let perShotSponsor = getSponsor.perShotArray[0]
        print("perShotSponsor: ", perShotSponsor)
        
        let donationSponsor = getSponsor.donationArray[0]
        print("donationSponsor: ", donationSponsor)
        
        
        //Query (team, player, event date) in donations table and then substract sponsor's perShot, flatDonation and totalDonation from sponssor table
        
        let getDonation = updateDonationsTotals.querySponsorWithShots(tName: team, pName: name, eDate: eventDate)
        
        
        let playerID = getDonation.sponsorID
        
        let playerTotalDonation = getDonation.totalDonation
        print("playerTotalDonation: ", playerTotalDonation)
        
        let playerTotPerShot = getDonation.totPerShot
        print("playerTotPerShot: ", playerTotPerShot)
        
        let playerTotFlatDonation = getDonation.totFlatDon
        print("playerTotFlatDonation: ", playerTotFlatDonation)
        
        let playerTotMake = getDonation.totMake
        print("playerTotMake: ", playerTotMake)
        
        
        // Recalculate these values (totPerShot, totFlatDonation, and totalDonation) and save in donations table
        
            
        let updatedTotPerShot = playerTotPerShot - perShotSponsor
        print("updatedTotPerShot: ", updatedTotPerShot)
        
        
        let playerPerShotCalc =   Double(playerTotMake) * perShotSponsor
        print("playerPerShotCalc: ", playerPerShotCalc)
        
       // let playerFlatDonCalc: Double = playerTotFlatDonation - donationSponsor
       // print("playerFlatDonCalc: ", playerFlatDonCalc)
        
        let updatedTotFlatDonation = playerTotFlatDonation - donationSponsor
        print("updatedTotFlatDonation: ", updatedTotFlatDonation)
        
        let updatedTotalDonation = playerTotalDonation - (playerPerShotCalc + donationSponsor)
        print("updatedTotalDonation: ", updatedTotalDonation)
        
        
        updateDonationsTotals.totalsUpdate(sponsorID: playerID, teamName: team, pName: name, totalPerShot: updatedTotPerShot, totalFlatDonation: updatedTotFlatDonation, totalDonation: updatedTotalDonation)
       
        

        //Delete sponsoer record
        let sponsorVerify = sponsorRecord.querySponsor(tName: team, pName: name, eDate: eventDate, sponsorN: sponsorN)
     
          let sponsorID = sponsorVerify
        
        
          CKContainer.default().publicCloudDatabase.delete(withRecordID: sponsorID) {(recordID, error) in
             
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

        
        
        var textMessDelete =  sponsorName.text!
          
          textMessDelete.append(" removed from ")
          
          textMessDelete.append(name)
        
        textMessDelete.append(" Sponsor List for ")
        
        textMessDelete.append(team)
        
        textMessDelete.append(" event")
        
       // textMessDelete.append(eventDate)
          
         print("textMessDelete: ", textMessDelete)
          
        
        //  messageTextView.text = textMessDelete
         
         let dialogMessage = UIAlertController(title: "Sponsor Removed", message: textMessDelete, preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)

         // Present Alert to
         self.present(dialogMessage, animated: true, completion: nil)
  
    } // deleteSponsor func


    
}  // SponsorMgmtViewController
