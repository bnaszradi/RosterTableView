//
//  SponsorTextViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 8/29/21.
//

import UIKit
import CloudKit
import MessageUI

class SponsorTextViewController: UIViewController, MFMessageComposeViewControllerDelegate {
   
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
   
        switch (result) {
               case .cancelled:
                   print("Message was cancelled")
                   dismiss(animated: true, completion: nil)
               case .failed:
                   print("Message failed")
                   dismiss(animated: true, completion: nil)
               case .sent:
                   print("Message was sent")
                   dismiss(animated: true, completion: nil)
               default:
               break
           }
    } // messageComposeViewController
    
    
    var name: String = ""
    var team: String = ""
    var eventName: String = ""
    var eventDate: Date = Date()
    var sponsorN: String = ""
    var totalAmount: Double = 0.0
    var phone: String = ""

    let eventTeamCheck = EventTeamCheck()
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playerName.text = name
        
       let sponsorsList = SponsorsList()
        
        let updateDonationsTotals = UpdateDonationsTotals()
        
        eventN.text = self.eventName
        sponsorName.text = self.sponsorN

        
        //Query to get this number of player makes
      //  let donationArray = updateDonationsTotals.querySponsorWithShots(tName: team, pName: name, eDate: eventDate)
     
        updateDonationsTotals.querySponsorWithShots(tName: team, pName: name, eDate: eventDate, completion: {
            qSpponsorWithShots in
            
           // self.eventN.text = self.eventName
           // self.sponsorName.text = self.sponsorN
    
            DispatchQueue.main.async {
               
                let donationArray = qSpponsorWithShots
                
                self.makes.text = String(donationArray.totMake)
        
        // Query to get perShot, donation and sponsor phone number
          //  let sponsorPhone = sponsorsList.sponsorPhoneQuery(tName: self.team, pName: self.name, eDate: self.eventDate, sponsorN: self.sponsorN)
        
                sponsorsList.sponsorPhoneQuery(tName: self.team, pName: self.name, eDate: self.eventDate, sponsorN: self.sponsorN, completion: { qsponsorPhoneQuery in
                    
                    DispatchQueue.main.async {
                      
                
              //  self.sponsorPhoneNumber.text = String(sponsorPhone.phoneN)
                self.sponsorPhoneNumber.text = String(qsponsorPhoneQuery.sponsorPhone)
               // self.phone = String(sponsorPhone.phoneN)
                self.phone = String(qsponsorPhoneQuery.sponsorPhone)
                        
                //self.perShot.text = String(sponsorPhone.perShot)
                self.perShot.text = String(qsponsorPhoneQuery.perShot)
        
               // self.flatDonation.text = String(sponsorPhone.donation)
                self.flatDonation.text = String(qsponsorPhoneQuery.donation)
        
              //  self.totalAmount = Double(donationArray.totMake) * sponsorPhone.perShot + sponsorPhone.donation
                        
                self.totalAmount = Double(donationArray.totMake) * qsponsorPhoneQuery.perShot + qsponsorPhoneQuery.donation
        
                self.total.text = String(self.totalAmount)
        
                    }  // DispatchQueue
                    
                } ) // Complettionhandler sponsorsList.sponsorPhoneQuery
                    
            } // DispatchQueue for completionhandker
        } ) // completionhandler updateDonationsTotals.querySponsorWithShots
                
        
    } //override
    
    
    
    @IBOutlet weak var playerName: UILabel!
    
    
    @IBOutlet weak var eventN: UILabel!
    
    
    @IBOutlet weak var sponsorName: UILabel!
    

    @IBOutlet weak var sponsorPhoneNumber: UILabel!
    
    @IBOutlet weak var makes: UILabel!
    
    
    @IBOutlet weak var perShot: UILabel!
    
    
    @IBOutlet weak var flatDonation: UILabel!
    
    
    @IBOutlet weak var total: UILabel!
    
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [phone]
        
        var textProse = "Thank you "
        textProse.append(sponsorN)
        textProse.append(", ")
        textProse.append(name)
        textProse.append(" appreciates your donation of $")
        textProse.append(total.text!)
        textProse.append(" for the ")
        textProse.append(team)
        textProse.append(" fundraiser: ")
        textProse.append(eventName)
        textProse.append(". ")
        
        //Fetch optional text for Event and add it to the text string
        
   //     let eventTxtResults = eventTeamCheck.eventText(team: team, eventN: eventName, eventD: eventDate)
        
        eventTeamCheck.eventText(team: team, eventN: eventName, eventD: eventDate, completion: { qEventText in
                
            DispatchQueue.main.async {
             
          //  let eventTxt = eventTxtResults.smsText
        
                let eventTxt = qEventText.smsText
        
        textProse.append(eventTxt)
        
        composeVC.body = textProse
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        } // if - else
                
            }  // DispatchQueue
            
        }  )   // CompletionHandler eventTeamCheck.eventText
                
                
    } //MFMessageComposeViewController
    
    
    @IBAction func textSponsor(_ sender: Any) {
    
        displayMessageInterface()
        
    }  //textSponsor
    
    
}  //SponsorTextViewController
