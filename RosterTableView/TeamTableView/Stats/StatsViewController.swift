//
//  StatsViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 1/21/21.
//

import UIKit
import CloudKit

class StatsViewController: UIViewController {

    var tName: String = ""
   // var playName: String = ""
    
    let teamCheck = TeamPlayerCheck()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
    }  // Override func
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    

    
    
    
   let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    @IBOutlet weak var teamName: UITextField!
    
    
    
    @IBAction func viewStatsButton(_ sender: Any) {
        
        self.tName = teamName.text!
        //self.playName = playerName.text!
        
        
        if tName == "" {
            
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
                
                
                let dialogMessage = UIAlertController(title: "Team not found", message: "Must enter an existing Team name", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                   // print("Ok button tapped")
                          
   
                })  // UIAlertAction ok
                
                
                dialogMessage.addAction(ok)
               
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)

                
            }  // else Team exists
            
            
        
        }  // if name

        
        performSegue(withIdentifier: "statsSegue", sender: self)
       
       // print("playName in StatsViewController button: ", playName)
        
    }  // viewStatsButton
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     //   messageText.text = " "
        
        let viewCont = segue.destination as! UINavigationController
        let collectionVC = viewCont.viewControllers.first as! StatsCollectionViewController
        
       // print("playName in StatsViewController prepare: ", playName)
        
       // collectionVC.player = self.playName
        collectionVC.team = self.tName
        collectionVC.title = self.tName
        
        
       
        
        } // prepare func
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
   @IBAction func unwindStatsCollectionViewControllerCancel(segue: UIStoryboardSegue) {
    
   }  // UIStoryboardSegue
    
    
    @IBAction func unwindBacktoStatsViewController(segue: UIStoryboardSegue) {
        
        teamName.text = tName
        
     }  // UIStoryboardSegue
    
    
    
}  // StatsViewController
