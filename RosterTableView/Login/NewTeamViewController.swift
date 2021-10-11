//
//  NewTeamViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/14/21.
//

import UIKit
import CloudKit

class NewTeamViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    } // Override viewDidLoad
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
    let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
    
    let loginCheck = LoginCheck()
    
    var tName: String = ""
    

    @IBOutlet weak var teamName: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var passwordVerify: UITextField!
    
    
    @IBAction func save(_ sender: UIButton) {
        
        let name = teamName.text!
       
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
      
        }  // if name is blank
        
            // Add check to determine if an extra blamk space was added to the team name when entered by user. If so, remove the blank character(s)
            
            var teamArray = Array(name)
            
            print("teamArray: ", teamArray)
            
           var teamNumChar = teamArray.count
           print("teamNumChar: ", teamNumChar)
            
           var extraTeamCharLessOne = teamNumChar - 1
            print("extraTeamCharLessOne: ", extraTeamCharLessOne)
            
            while teamArray[extraTeamCharLessOne] == " " {
                
                teamArray.remove(at: extraTeamCharLessOne)
                print("teamArray after remove end blank character: ", teamArray)
                
               teamNumChar = teamArray.count
               print("teamNumChar: ", teamNumChar)
                
            extraTeamCharLessOne = teamNumChar - 1
            print("extraTeamCharLessOne: ", extraTeamCharLessOne)
                
            } // while extraTeamCharLessOne
            
            tName = String(teamArray)
            
            print("tname after parsing blank characters from end: ", tName)
            
            //Check password entry
            let pwd = password.text!
            print("pwd: ", pwd)
           
            if pwd == "" {
                
                // Create Alert for Password
                 let dialogMessage = UIAlertController(title: "Missing Password", message: "Must enter a Password of 6 digits or more (case sensitive) in length", preferredStyle: .alert)
                 
                 // Create OK button with action handler
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                 
                 //Add OK button to a dialog message
                 dialogMessage.addAction(ok)

                 // Present Alert to
                 self.present(dialogMessage, animated: true, completion: nil)

                return
          
            } // if pwd is blank
        
        
        //Check passwordVerify entry
        let pwdVerify = passwordVerify.text!
        print("pwdVerify: ", pwdVerify)
       
        if pwdVerify == "" {
            
            // Create Alert for Password
             let dialogMessage = UIAlertController(title: "Missing Password Check", message: "Must re-enter the password that matches the password above", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
      
        } // if pwd is blank
    
            
                // Add check to determine if an extra blamk space was added to the password when entered by user. If so, remove the blank character(s)
                
                var pwdArray = Array(pwd)
                
                print("pwdArray: ", pwdArray)
                
                var pwdNumChar = pwdArray.count
               print("pwdNumChar: ", pwdNumChar)
                
               var extraPwdCharLessOne = pwdNumChar - 1
                print("extraPwdCharLessOne: ", extraPwdCharLessOne)
                
                while pwdArray[extraPwdCharLessOne] == " " {
                    
                    pwdArray.remove(at: extraPwdCharLessOne)
                    print("pwdArray after remove end blank character: ", pwdArray)
                    
                   pwdNumChar = pwdArray.count
                   print("pwdNumChar: ", pwdNumChar)
                    
                extraPwdCharLessOne = pwdNumChar - 1
                print("extraPwdCharLessOne: ", extraPwdCharLessOne)
                    
                } // while password
        
        //Check password to ensure that the password is 6 digits or more in length
           
           if pwdArray.count >= 6 {
              
              // var pword = String(pwdArray)
                 
               print("pwdArray.count: ", pwdArray.count)
               
           } else {
             
               // Create Alert for Password length
                let dialogMessage = UIAlertController(title: "Password", message: "Must enter a Password of 6 digits or more (case sensitive) in length", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)

                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)

               return
         
           } // if else password in 6 digits
      
         let pword = String(pwdArray)
   
           print("password after parsing blank characters from end and 6 character check: ", pword)
       
        
        // Add check to determine if an extra blamk space was added to the passwordVerify when entered by user. If so, remove the blank character(s)
        
        var pwdVerifyArray = Array(pwdVerify)
        
        print("pwdVerifyArray: ", pwdVerifyArray)
        
        var pwdVerifyNumChar = pwdVerifyArray.count
       print("pwdVerifyNumChar: ", pwdVerifyNumChar)
        
       var extraPwdVerifyCharLessOne = pwdVerifyNumChar - 1
        print("extraPwdVerifyCharLessOne: ", extraPwdVerifyCharLessOne)
        
        while pwdVerifyArray[extraPwdVerifyCharLessOne] == " " {
            
            pwdVerifyArray.remove(at: extraPwdVerifyCharLessOne)
            print("pwdVerifyArray after remove end blank character: ", pwdVerifyArray)
            
           pwdVerifyNumChar = pwdVerifyArray.count
           print("pwdVerifyNumChar: ", pwdVerifyNumChar)
            
        extraPwdVerifyCharLessOne = pwdVerifyNumChar - 1
        print("extraPwdVerifyCharLessOne: ", extraPwdVerifyCharLessOne)
            
        } // while

        let pwordVerify = String(pwdVerifyArray)
        
        
        // Check if password == passwordVerify
        
        if pwordVerify == pword {
            
            // Check if team and password already exists in School DB

            let passwordCheck = loginCheck.pwdTeamCheck(team: tName, password: pword)
        
            print("passwordCheck.count: ", passwordCheck.count)
            
            if passwordCheck.count > 0 {
                
                let dialogMessage = UIAlertController(title: "Team and Password combination already used.", message: "Choose a different team name and password combination", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                   // print("Ok button tapped")
                  
                    return
                
                })  // UIAlertAction ok
                
            
                //Add OK button to dialog message
                dialogMessage.addAction(ok)
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
                return
                
            } // If passwordCheck.count > 0
           
            
            // Save password and teamName in school DB
            
            let recordSchool = CKRecord(recordType: "school")
        
            recordSchool["teamName"] = tName
            
            recordSchool["password"] = pword
            
            CKContainer.default().publicCloudDatabase.save(recordSchool) { record, error in
                    DispatchQueue.main.async {
                       if error == nil {
                            
                        } else {
                           let ac = UIAlertController(title: "Error", message: "There was a problem submitting your data \(error!.localizedDescription)", preferredStyle: .alert)
                           ac.addAction(UIAlertAction(title: "OK", style: .default))
                          //  self.persent(ac, animated: true)
                        }  // else
                        
                  } //if error
                 } // DispatchQueue
           
                
            var textDisplay = tName
            
            textDisplay.append(" and password added")
            
                let dialogMessage = UIAlertController(title: "Team Added", message: textDisplay, preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                      })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)

                
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
            
            
        }  else {
            // Create Alert for Password
             let dialogMessage = UIAlertController(title: "Passwords don't match", message: "Passwords in both fields must match", preferredStyle: .alert)
             
             // Create OK button with action handler
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
             
             //Add OK button to a dialog message
             dialogMessage.addAction(ok)

             // Present Alert to
             self.present(dialogMessage, animated: true, completion: nil)

            return
      
        } // if pwd == pwdVerify
    
        
    } // save button
    

}  // NewTeamViewController
