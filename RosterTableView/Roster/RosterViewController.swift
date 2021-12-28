//
//  RosterViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 12/25/20.
//

import UIKit
import CloudKit



class RosterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var name: String = ""
    
  //  var teamArray = [] as Array<String>
    
   let teamCheck = TeamPlayerCheck()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = tabBarController as! InitialTabBarViewController
       // teamName.text = String(describing: tabBar.teamName)
        
        let name =  String(describing: tabBar.teamName)
        
        // Remove any blank characters at the end of the team name
        var teamArray = Array(name)
        
        print("teamArray in RosterViewController: ", teamArray)
        
       var teamNumChar = teamArray.count
       print("teamNumChar in RosterViewController: ", teamNumChar)
        
       var extraTeamCharLessOne = teamNumChar - 1
      //  print("extraTeamCharLessOne: ", extraTeamCharLessOne)
        
        while teamArray[extraTeamCharLessOne] == " " {
            
            teamArray.remove(at: extraTeamCharLessOne)
            print("teamArray after remove end blank character: ", teamArray)
            
           teamNumChar = teamArray.count
           print("teamNumChar: ", teamNumChar)
            
        extraTeamCharLessOne = teamNumChar - 1
        print("extraTeamCharLessOne: ", extraTeamCharLessOne)
            
        } // while extraTeamCharLessOne
        
        teamName.text = String(teamArray)
        
      //  print("tname after parsing blank characters from end: ", teamName.text)
        
        // This code hides the navigation bar in the navigation controller
        super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
        
        
        
    }  //override func
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    
   // let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    @IBOutlet weak var teamName: UILabel!
    

    @IBAction func rosterName(_ sender: Any) {

        name = teamName.text!
       
            // Add check if team roster already exists
            /*
            let teamVerify = teamCheck.TeamCheck(team: name)
        
            print("teamVerify.count: ", teamVerify.count)
            
            if teamVerify.count == 0 {
                
                
                let dialogMessage = UIAlertController(title: "Team roster not found", message: "Do you want to create this new team roster?", preferredStyle: .alert)
                
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
            */
    
        performSegue(withIdentifier: "teamPasser", sender: self)
        
    }  //IBAction func rosterName
    

    
    
    @IBAction func eventsNames(_ sender: UIButton) {
        
        name = teamName.text!
            
                performSegue(withIdentifier: "eventsListPasser", sender: self)
                print("eventsListPasser segue")
                
       
    } // eventsNames
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "teamPasser" {
          
                    print("teamPasser Segue")
             
            let playersVar: Bool = true
            
            let vc = segue.destination as! UINavigationController
            let tableVC = vc.viewControllers.first as! TeamTableViewTableViewController
            tableVC.team = self.name
            tableVC.title = self.name
            tableVC.playerVariable = playersVar
            
            
            
            } else if segue.identifier == "eventsListPasser" {
            
                    
                    print("eventsListPasser Segue")
                    
                  //  if let selectedPlayer = sender as? String {
                   
                        let vcEventsList = segue.destination as! UINavigationController
                       
                        let vc = vcEventsList.viewControllers.first as! EventsCollectionViewController
                        
                       vc.team = name
                        
                      //  vcScore.playerN = player
                        
                        print("vc.team: ", vc.team)
                        
                       // print("vcScore.team ", vcScore.team)
                    
                  //  let eventVar: Bool = true
                    let playerVar: Bool = true
                    var Title = name
                    Title.append(" Events")
                
                    vc.title = Title
                    vc.team = self.name
                 //   vc.eventVariable = eventVar
                vc.playerVariable = playerVar
                        
                 //   } // if selecterdPlayer

                    
                } // to ScoreViewController
          
        
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
    
    
    @IBAction func unwindBacktoRosterview (segue: UIStoryboardSegue) {
        
        print("unwind from eventsCollectionViewController")
        
        teamName.text = name
        
        
     }  // UIStoryboardSegue
    
    
    
    
}  //RosterViewController

