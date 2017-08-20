//
//  CreateAccountViewController.swift
//  SocialLoginApp
//
//  Created by VS on 8/10/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit

import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPwd: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    /** @var handle
     @brief The handler for the auth state listener, to allow cancelling later.
     */
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        //load placeholders.
        txtName.placeholder = "your name"
        txtEmailAddress.placeholder = "enter your email address"
        txtPassword.placeholder = "enter your password"
        txtConfirmPwd.placeholder =  "confirm password"
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            //            self.setTitleDisplay(user)
            //            self.tableView.reloadData()
            // [END_EXCLUDE]
            
        }
        // [END auth_listener]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    func showMessagePrompt(title: String,message:String){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didCreateAccount(_ sender: Any) {
        
        if validateForm(){
        if let email = self.txtEmailAddress.text, let password = self.txtPassword.text {
            // [START create_user]
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                    if let error = error {
                        self.showMessagePrompt(title: "error", message: error.localizedDescription)
                        return
                    }
                    print("\(user!.email!) created")
            }
            // [END create_user]
            
            }
        }
    }
    
    //validate the user input form
    func validateForm() -> Bool{
        
        
        //should have a valid name
        let nameCount = (txtName.text?.characters.count)! > 0
        if nameCount == false {
            return false
            showMessagePrompt(title: "Error", message: "Please fill your name.")
        }
        
        //check if email address is valid
        let isEmailValid = isValidEmail(testStr: (txtEmailAddress.text)!)
        if isEmailValid == false {
            showMessagePrompt(title: "Error", message: "Please enter a valid email addresss.")
            return false
        }
        
        //return negative when
        let matchPwds = txtPassword.text?.isEqual(txtConfirmPwd.text)
        if matchPwds == false {
            showMessagePrompt(title: "Error", message: "Password's does not match. please re-enter password's.")
            return false
        }
        
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
