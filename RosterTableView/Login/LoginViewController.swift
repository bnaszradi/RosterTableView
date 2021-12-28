//
//  LoginViewController.swift
//  RosterTableView
//
//  Created by Brian Naszradi on 9/11/21.
//

import UIKit
import CloudKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    } //viewDidLoad
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
          super.touchesBegan(touches, with: event)
          }  // touchesBegan
    
    
   let container = CKContainer(identifier: "ICloud.Brian-Naszradi.RosterTableView")
    
  //  let container = (UIApplication.shared.delegate as! AppDelegate).container

    
   // let teamCheck = TeamPlayerCheck()
    
    let loginModel = LoginModel()
    
    var tName: String = ""
    
    var passwordCheck: Array<Any> = []
    
    @IBOutlet weak var teamName: UITextField!
    

    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func newTeam(_ sender: UIButton) {
    
    } //newTeam
    
    
    
    @IBAction func login(_ sender: UIButton) {
    
        let name = teamName.text!
        let pwd = password.text!
        print("pwd: ", pwd)
    
       // Hide password as soon as read
        password.text = "******"
       
       
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
        
            // Add check to determine if an extra blank space was added to the team name when entered by user. If so, remove the blank character(s)
            
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
            
            print("name after parsing blank characters from end: ", tName)
            
            //Check password entry
          //  let pwd = password.text!
          //  print("pwd: ", pwd)
        
           // Hide password as soon as read
          //  password.text = "******"
           
            if pwd == "" {
                
                // Create Alert for Password
                 let dialogMessage = UIAlertController(title: "Missing Password", message: "Must enter a Password of 6 digits (case sensitive) in length", preferredStyle: .alert)
                 
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
            
                // Add check to determine if an extra blank space was added to the password when entered by user. If so, remove the blank character(s)
                
                var pwdArray = Array(pwd)
                
                print("pwdArray: ", pwdArray)
                
                var pwdNumChar = pwdArray.count
               print("teamNumChar: ", pwdNumChar)
                
               var extraPwdCharLessOne = pwdNumChar - 1
                print("extraPwdCharLessOne: ", extraPwdCharLessOne)
                
                while pwdArray[extraPwdCharLessOne] == " " {
                    
                    pwdArray.remove(at: extraPwdCharLessOne)
                    print("pwdArray after remove end blank character: ", pwdArray)
                    
                   pwdNumChar = pwdArray.count
                   print("pwdNumChar: ", pwdNumChar)
                    
                extraPwdCharLessOne = pwdNumChar - 1
                print("extraPwdCharLessOne: ", extraPwdCharLessOne)
                    
                } // while
        
        let pword = String(pwdArray)
  
          print("password after parsing blank characters from end and 6 character check: ", pword)
        
            // Check if team and password already exists in User DB
       // let PasswordArray: Array<String> = []
        
       // var passwordCheck: Array<Any> = []
        
       
        loginModel.pwdTeamPwdCheck(team: tName, password: pword) { [self] (result) in
                                     
        DispatchQueue.main.async {
            self.passwordCheck = result
            print("passwordCheck in loginModel.pwdTeamcheck: ", self.passwordCheck)
            
           check(passwordCheck: passwordCheck)
            
        } // DispatchQueue
        
       } // loginModel.pwdTeamCheck
        
        func check(passwordCheck: Array<Any>) {
            
            print("passwordCheck.count: ", passwordCheck.count)
        
            if passwordCheck.count == 0 {
                
                print("passwordCheck.count after if: ", passwordCheck.count)
                
                let dialogMessage = UIAlertController(title: "Team and Password combination not found", message: "Correct Team and/or Password and retry or select New Team button to create a new team.", preferredStyle: .alert)
                
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
                
            } // If passwordCheck == Team and Password
          
       
        
                performSegue(withIdentifier: "initialTabBar", sender: self)
         
        } // func check
        
    } //login button
    
    
    
    @IBAction func unwindNewTeamViewControllerCancel(segue:UIStoryboardSegue) {
       }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "initialTabBar" {
          
            print("initialTabBar Segue")
             
            let vc = segue.destination as! InitialTabBarViewController
           
            vc.teamName = teamName.text!
          //  vc.title = "Swish Basketball"
           
        } // if segue in initialTabBar
           
        } // prepare func
    
    
        
}  //LoginViewController

