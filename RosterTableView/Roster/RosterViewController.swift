//
//  RosterViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/25/20.
//

import UIKit
import CloudKit
//import MobileCoreServices


class RosterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var name: String = ""
    
  //  var playerName: String = ""
    
    //var playerArray = [] as Array<String>
    
   let teamCheck = TeamPlayerCheck()
    
  //  let playerSearch = UpdateTeamTotals()
 
   // var playerID: CKRecord.ID = CKRecord.ID()
    
    
 //   var pickerController = UIImagePickerController()
    
  // var photoURL = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()

     //   pickerController.delegate = self
        
    }  //override func
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    @IBOutlet weak var teamName: UITextField!
    
    

    @IBAction func rosterName(_ sender: Any) {

        name = teamName.text!
       
        if name == "" {
            
            // Create Alert for Team
             let dialogMessage = UIAlertController(title: "Missing Team", message: "Must enter Team", preferredStyle: .alert)
             
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
        
            // Add check if team already exists
            
            let teamN = teamName.text!
            
            let teamVerify = teamCheck.TeamCheck(team: teamN)
        
            if teamVerify.count == 0 {
                
                
                let dialogMessage = UIAlertController(title: "Team not found", message: "Do you want to create this new Team?", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                   // print("Ok button tapped")
                    
                    self.performSegue(withIdentifier: "teamPasser", sender: self)
                    
   
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

                
            } else {
                
            
                performSegue(withIdentifier: "teamPasser", sender: self)
                
            }  // else Team exists
            
            
       // performSegue(withIdentifier: "teamPasser", sender: self)
        
        }  // if name
        
    }  //IBAction func rosterName
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       //messageText.text = " "
        
      //  messageTextView.text = " "
        
        let vc = segue.destination as! UINavigationController
        let tableVC = vc.viewControllers.first as! TeamTableViewTableViewController
        tableVC.team = self.name
        tableVC.title = self.name
        
        } // prepare func
        
   
    
    
    @IBAction func unwindTeamTableViewTableViewControllerCancel(segue:UIStoryboardSegue) {
       }
    
    /*
    @IBAction func unwindPlayerManagementCancel(segue: UIStoryboardSegue) {
         
        let vc = segue.destination as! UINavigationController
        let tableVC = vc.viewControllers.first as! TeamTableViewTableViewController
        tableVC.team = self.name
        tableVC.title = self.name
        
    } //unwindPlayerManagementCancel
    */
    
    
    
    
    
}  //RosterViewController

