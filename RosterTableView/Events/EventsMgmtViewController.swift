//
//  EventsMgmtViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 6/14/21.
//

import UIKit
import CloudKit


extension UITextField {
    
    func setDatePickerAsInputViewFor(target:Any, selector:Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 200.0))
        datePicker.datePickerMode = .date
        
        datePicker.backgroundColor = .white
        
        datePicker.setValue(UIColor.black, forKey: "textColor")
        
        
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 40.0))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        toolBar.setItems([cancel,flexibleSpace, done], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}  //UITextField extension



class EventsMgmtViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        self.eventDate.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        
        
        textMessage.isScrollEnabled = false
        
    } // viewDidLoad
    
    
    
    @objc func dateSelected() {
            if let datePicker = self.eventDate.inputView as? UIDatePicker {
                
                //Format the date for viewing
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full  //options: medium, long, full
               // dateFormatter.timeStyle = .none
                
                datePicker.setValue(UIColor.black, forKey: "textColor")
                
                self.eventDate.text = dateFormatter.string(from: datePicker.date)
                
                //Set date variable for search
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeStyle = .none
                
               // eDate = dateFormatter.date(from: eventDate as! String)
                let eDateText = dateFormatter.string (for: datePicker.date)
                
                print("eDateText: ", eDateText!)
                
                eDate = dateFormatter.date(from: eDateText!)!
                
                print("eDate: ", eDate)
               
                // This works but includes that time
              //  eDate = datePicker.date
                
                
            }  // if datePicker
            self.eventDate.resignFirstResponder()
      
    } //dateSelected func
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")

    var name: String = ""
    var tName: String = ""
    var eName: String = ""
    var eDateCheck: String = ""
    
    var eDate: Date = Date()
   
    
    var eventID: CKRecord.ID = CKRecord.ID()
    
    var teamPlayerCheck = TeamPlayerCheck()
    
    var eventTeamCheck = EventTeamCheck()
    
    var updateDonationTotals = UpdateDonationsTotals()
    
    var updateTeamTotals = UpdateTeamTotals()
    
    let dispatchGroup = DispatchGroup()
    
    
    @IBOutlet weak var eventName: UITextField!
    
    
    @IBOutlet weak var eventDate: UITextField!
    
    
    @IBOutlet weak var textMessage: UITextView!
    
    
    @IBAction func addEvent(_ sender: UIButton) {

        // Check for Event and Event Date in events type
        
        print("name: ", name)
        tName = name
        print("tName: ", tName)
        
        eName = eventName.text!
        print("eName: ", eName)
        
        eDateCheck = eventDate.text!
        
            if eName == "" {
               
                // Create Event Name alert
                 let dialogMessage = UIAlertController(title: "Missing Event Name", message: "Must enter an event name", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            }  else {
                
                if eDateCheck == "" {
                    
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Missing Event Date", message: "Must enter an event date", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    return
                    
                } //eDateCheck
            
     
                // Add check to determine if an extra blamk space was added to the event name when entered by user. If so, remove the blank character(s)
                
                var eventArray = Array(eName)
                
                print("eventArray: ", eventArray)
                
               var eventNumChar = eventArray.count
               print("eventNumChar: ", eventNumChar)
                
               var extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                
                while eventArray[extraEventCharLessOne] == " " {
                    
                    eventArray.remove(at: extraEventCharLessOne)
                    print("eventArray after remove end blank character: ", eventArray)
                    
                   eventNumChar = eventArray.count
                   print("eventNumChar: ", eventNumChar)
                    
                extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                    
                } // if eventArray
                
                eName = String(eventArray)
                
                print("eName after parsing blank characters from end: ", eName)
            
                
        // Check to see if this is a duplicate event by checking eventDate
            print("Add Event: team name before check: ", name)
            print("Add Event: eventDate before check: ", eDate)
            print("Add Event: eventName before check: ", eName)
                
                
       let check = teamPlayerCheck.EventCheck(team: name, eventDate: eDate, eventName: eName)
        print("check.count: ", check.count)
        
        if check.count > 0 {
          
            //Duplicate event detected
            
            // Create new Alert
             let dialogMessage = UIAlertController(title: "Duplicate", message: "Duplicate Event for this Date detected for this Team. Re-enter a different Event date for this Team ", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)
            
            return
            
        } //Check count if event already exists
        
        let recordEvent = CKRecord(recordType: "events")
        
        recordEvent["eventName"] = eName
        
        recordEvent["team"] = tName
        
        print("eDate to be stored in DB: ", eDate)
        recordEvent["eventDate"] = eDate
            
        if textMessage.text == "Enter text here" {
                    textMessage.text = "."
                }
        print("textMessage in add event button: ", textMessage.text!)
                
        recordEvent["textMessage"] = textMessage.text!
        
                
            CKContainer.default().publicCloudDatabase.save(recordEvent) { record, error in
                DispatchQueue.main.async {
                   if error == nil {
                        
                    } else {
                       let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                       ac.addAction(UIAlertAction(title: "OK", style: .default))
                      //  self.persent(ac, animated: true)
                    }  // else
                    
              } //if error
             } // DispatchQueue
       
            
        var textDisplay = eName
        
        textDisplay.append(" added to ")
        
        textDisplay.append(tName)
        
        textDisplay.append(" events list")
        
       print("textDisplay: ", textDisplay)
        
            let dialogMessage = UIAlertController(title: "Event Added", message: textDisplay, preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                  })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)

            
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
           
            } // else if
        
        
        
    } // addEvent button
    
        
    @IBAction func retrieveText(_ sender: UIButton) {
        
        print("name: ", name)
        tName = name
        print("tName: ", tName)
        
        eName = eventName.text!
        print("eName: ", eName)
        
        eDateCheck = eventDate.text!
        
            if eName == "" {
               
                // Create Event Name alert
                 let dialogMessage = UIAlertController(title: "Missing Event Name", message: "Must enter an event name", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            }  else {
                
                if eDateCheck == "" {
                    
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Missing Event Date", message: "Must enter an event date", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    return
                    
                } //eDateCheck
            
     
                // Add check to determine if an extra blamk space was added to the event name when entered by user. If so, remove the blank character(s)
                
                var eventArray = Array(eName)
                
                print("eventArray: ", eventArray)
                
               var eventNumChar = eventArray.count
               print("eventNumChar: ", eventNumChar)
                
               var extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                
                while eventArray[extraEventCharLessOne] == " " {
                    
                    eventArray.remove(at: extraEventCharLessOne)
                    print("eventArray after remove end blank character: ", eventArray)
                    
                   eventNumChar = eventArray.count
                   print("eventNumChar: ", eventNumChar)
                    
                extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                    
                } // if eventArray
                
                print("eventArray after parsing: ", eventArray.count)
                
                eName = String(eventArray)
                
                print("eName after parsing blank characters from end: ", eName)
        
          } // else if
        
        // Check if event already exists
        
         let eventVerify = teamPlayerCheck.EventCheck(team: tName, eventDate: eDate, eventName: eName)
     
         if eventVerify.count == 0 {
             
             let dialogMessage = UIAlertController(title: "Event not found", message: "Re-enter correct date for event", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                // print("Ok button tapped")
                 
                 return

             })  // UIAlertAction ok
             
             dialogMessage.addAction(ok)
            
             // Present dialog message to user
             self.present(dialogMessage, animated: true, completion: nil)

         } //if eventVerify check
        
        print("name before eventText: ", name)
        print("eName before eventText: ", eName)
        print("eDate before eventText: ", eDate)
        
        let eventTxt = eventTeamCheck.eventText(team: tName, eventN: eName, eventD: eDate)
        
        print("eventTxt: ", eventTxt)
        
        textMessage.text = eventTxt.smsText
        
        var textDisplay = "SMS text retrieved for "
        
        textDisplay.append(eName)
        
        textDisplay.append(" event")
        
        let dialogMessage = UIAlertController(title: "Event SMS Text Retrieved", message: textDisplay, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
              })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
        
      //  } // else if

    } // retrieveText button
    
    
    
    @IBAction func updateText(_ sender: UIButton) {
   
        print("name: ", name)
        tName = name
        print("tName: ", tName)
        
        eName = eventName.text!
        print("eName: ", eName)
        
        eDateCheck = eventDate.text!
        
            if eName == "" {
               
                // Create Event Name alert
                 let dialogMessage = UIAlertController(title: "Missing Event Name", message: "Must enter an event name", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            }  else {
                
                if eDateCheck == "" {
                    
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Missing Event Date", message: "Must enter an event date", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    return
                    
                } //eDateCheck
            
     
                // Add check to determine if an extra blamk space was added to the event name when entered by user. If so, remove the blank character(s)
                
                var eventArray = Array(eName)
                
                print("eventArray: ", eventArray)
                
               var eventNumChar = eventArray.count
               print("eventNumChar: ", eventNumChar)
                
               var extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                
                while eventArray[extraEventCharLessOne] == " " {
                    
                    eventArray.remove(at: extraEventCharLessOne)
                    print("eventArray after remove end blank character: ", eventArray)
                    
                   eventNumChar = eventArray.count
                   print("eventNumChar: ", eventNumChar)
                    
                extraEventCharLessOne = eventNumChar - 1
                print("extraEventCharLessOne: ", extraEventCharLessOne)
                    
                } // if eventArray
                
                eName = String(eventArray)
                
                print("eName after parsing blank characters from end: ", eName)
        
            } // else if
        
        // Check if event already exists
        
         let eventVerify = teamPlayerCheck.EventCheck(team: tName, eventDate: eDate, eventName: eName)
     
         if eventVerify.count == 0 {
             
             
             let dialogMessage = UIAlertController(title: "Event not found", message: "Re-enter correct date for event", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                // print("Ok button tapped")
                 
                 return

             })  // UIAlertAction ok
             
             dialogMessage.addAction(ok)
            
             // Present dialog message to user
             self.present(dialogMessage, animated: true, completion: nil)

         } //if eventVerify check
        
        print("name before eventText: ", name)
        print("eventName before eventText: ", eventName.text!)
        print("eDate before eventText: ", eDate)
        
        let eventTxt = eventTeamCheck.eventText(team: tName, eventN: eName, eventD: eDate)
        
        print("eventTxt: ", eventTxt)
        
        let textMess = textMessage.text!
        
       let eventIdent = eventTxt.eventID
        
        eventTeamCheck.updateEventText(eventID: eventIdent, textMessage: textMess)
        
        var textDisplay = "SMS text updated for "
        
        textDisplay.append(eName)
        
        textDisplay.append(" event")
        
        let dialogMessage = UIAlertController(title: "Event SMS Text Updated", message: textDisplay, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
              })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)

        
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
        
    } // updateText button
    
    
    
    
    @IBAction func deleteEvent(_ sender: UIButton) {
        
       // tName = name
        // print("tName: ", tName)
        
        eName = eventName.text!
        print("eName: ", eName)
        
        eDateCheck = eventDate.text!
        
        // Check that event name and date are entered
        
            if eName == "" {
               
                // Create Event Name alert
                 let dialogMessage = UIAlertController(title: "Missing Event Name", message: "Must enter an event name", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
                
            }  else {
                
                if eDateCheck == "" {
                    
                    // Create Event Date alert
                     let dialogMessage = UIAlertController(title: "Missing Event Date", message: "Must enter an event date", preferredStyle: .alert)
                     
                     // Create OK button with action handler
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                     
                     //Add OK button to a dialog message
                     dialogMessage.addAction(ok)

                     // Present Alert to
                     self.present(dialogMessage, animated: true, completion: nil)

                    return
                    
                } //eDateCheck
        
        // Add check to determine if an extra blamk space was added to the event name when entered by user. If so, remove the blank character(s)
        
        var eventArray = Array(eName)
        
        print("eventArray: ", eventArray)
        
       var eventNumChar = eventArray.count
       print("eventNumChar: ", eventNumChar)
        
       var extraEventCharLessOne = eventNumChar - 1
        print("extraEventCharLessOne: ", extraEventCharLessOne)
        
        while eventArray[extraEventCharLessOne] == " " {
            
            eventArray.remove(at: extraEventCharLessOne)
            print("eventArray after remove end blank character: ", eventArray)
            
           eventNumChar = eventArray.count
           print("eventNumChar: ", eventNumChar)
            
        extraEventCharLessOne = eventNumChar - 1
        print("extraEventCharLessOne: ", extraEventCharLessOne)
            
        } // while eventArray
        
        eName = String(eventArray)
        
        print("eName after parsing blank characters from end: ", eName)

        print("Delete Event: team name before check: ", name)
        print("Delete Event: eventDate before check: ", eDate)
        print("Delete Event: eventName before check: ", eName)
        
            
        // Check if event already exists
        
         let eventVerify = teamPlayerCheck.EventCheck(team: name, eventDate: eDate, eventName: eName)
     
         if eventVerify.count == 0 {
             
             
             let dialogMessage = UIAlertController(title: "Event not found", message: "Re-enter correct date for event", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                // print("Ok button tapped")
                 
               
                 return

             })  // UIAlertAction ok
             
             dialogMessage.addAction(ok)
            
             // Present dialog message to user
             self.present(dialogMessage, animated: true, completion: nil)

         } //if eventVerify check
         
        
        // If event exists present dialog to confirm deletion
                
         let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // print("Ok button tapped")
            self.deleteRecord(eName: self.eName, eDate: self.eDate)
             
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
           
            } // Ok alert
                
     }  // deletePlayer
     
    
    func deleteRecord(eName: String, eDate: Date)
     {
         print("Delete record function called")
         
         print("team name in delete: ", name)
          
        
        //Retrieve donations DB record totAttempt, totMake for team, player, event
        
        // Retrieve team DB record for player and reduce TotAttempts, TotMakes, TotPercentage by totAttempt and totMake from donations DB. Recalculate the TotPercentage based upon updated TotAttempts and TotMakes
      //  print("tname before donationRecord: ", name)
      //  print("eName before donationRecord: ", eName)
      //  print("eDate before donationRecord: ", eDate)
        
        
        // Show that activity spinner
        self.showSpinner()
        print("spinner started")
        
        dispatchGroup.notify(queue: .main) { [self] in
            
            self.dispatchGroup.enter()
            
        
        let donationRecord = updateDonationTotals.queryDonationPlayers(team: name, eventName: eName, eventDate: eDate)
        
        print("donationRecord player \(donationRecord.player)")
        
        let donationRecordCount = donationRecord.player.count
        
        var recordCounter = 0
        
        while recordCounter < donationRecordCount {
            print("recordCounter: ", recordCounter)
            
            let teamRecord = updateTeamTotals.queryPlayer(pName: donationRecord.player[recordCounter], team: donationRecord.team[recordCounter])
            
            print("teamRecord.totalAttempts: ", teamRecord.totalAttempts)
            print("donationRecord.totAttempt[recordCounter]: ", donationRecord.totAttempt[recordCounter])
            
            let totAttempt = teamRecord.totalAttempts - donationRecord.totAttempt[recordCounter]
        
            print("totAttempt: ", totAttempt)
            
            print("teamRecord.totalMakes: ", teamRecord.totalMakes)
            print("donationRecord.totMake[recordCounter]: ", donationRecord.totMake[recordCounter])
            
            let totMake = teamRecord.totalMakes - donationRecord.totMake[recordCounter]
            
            print("totMake: ", totMake)
            
            let shotP = Double(Double(totMake)/Double(totAttempt))
            
            let totPercent = Double(round(shotP*1000)/1000) * 100
            
            print("totPercent: ", totPercent)
            
            let newDate = Date()
            print("newDate: ", newDate)
            
            let playerId = teamRecord.playID
            
            let playerN = donationRecord.player[recordCounter]
            
            updateTeamTotals.totalsUpdate(playerID: playerId, teamName: name, pName: playerN, attempts: totAttempt, totalMakes: totMake, shotPercentage: totPercent, scoreDate: newDate)
            
            recordCounter += 1
        } // while recordCounter
        
        let eventVerify = eventTeamCheck.queryEvent(team: name, eventN: eName, eventD: eDate)
         
          eventID = eventVerify
        
        
        
          CKContainer.default().publicCloudDatabase.delete(withRecordID: eventID) {(recordID, error) in
             
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

        
          var textMessDelete = eventName.text!
          
          textMessDelete.append(" removed from ")
          
          textMessDelete.append(name)
          
         print("textMessDelete: ", textMessDelete)
          
         let dialogMessage = UIAlertController(title: "Event Removed", message: textMessDelete, preferredStyle: .alert)
         
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
  
        } // dispatchGroup.notify
      
            
    } // deleteEvent
    
    
    
    
}  // EventsMgmtViewController
