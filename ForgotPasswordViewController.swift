//
//  ForgotPasswordViewController.swift
//  SocialLoginApp
//
//  Created by VS on 8/10/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    /** @var handle
     @brief The handler for the auth state listener, to allow cancelling later.
     */
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.placeholder = "email address"
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
    
    @IBAction func btnForgot(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
            if let error = error {
                self.showMessagePrompt(title: "error", message: error.localizedDescription)
                return
            }
            
            self.showMessagePrompt(title: "email sent!", message: "iOptic has sent a reset password link your email. Please update your password and login.")
        }
        
    }
    
    
    func showMessagePrompt(title: String,message:String){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }


}
