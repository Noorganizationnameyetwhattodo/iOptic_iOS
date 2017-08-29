//
//  ViewController.swift
//  SocialLoginApp
//
//  Created by VS on 8/9/17.
//  Copyright © 2017 VS. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {

    /** @var handle
     @brief The handler for the auth state listener, to allow cancelling later.
     */
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnCreateAccnt: UIButton!
    @IBOutlet weak var gSign: GIDSignInButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.placeholder = "Email Address"
        passwordField.placeholder = "Password"

       /* //google sign in button
        let googleSignButton = GIDSignInButton()
        googleSignButton.frame = CGRect(x: 16 , y: 180, width: view.frame.width-32, height: 40)
        view.addSubview(googleSignButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //facebook related code
        let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(x: 16 , y: 250, width: view.frame.width-36, height: 45)
        view.addSubview(loginButton)
        
        loginButton.delegate = self*/
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        }
        print("successfully logged in ")
        showMessagePrompt(title: "Success", message: "succesfully logged in with facebook.")
        return
    }
    
    
    
    @IBAction func signInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
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
    
    @IBAction func didSigninAccount(_ sender: Any) {
        if let email = self.emailField.text, let password = self.passwordField.text {
            
            self.showSpinner {

                // [START headless_email_auth]
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.hideSpinner {
                            self.showMessagePrompt(error.localizedDescription)
                            return
                        }
                    }
                    if let user = user {
                        
                        self.hideSpinner {
                            
                            if user.isEmailVerified == false {
                                
                                let msg = "Please verify your email address and login again. Click Resend if you missed it."
                                let buttonTitles = ["OK","RESEND"]
                                self.showMessagePrompt(msg, withTitle:"Verify Email Address", withButtonTitles:buttonTitles){(index) in
                                    if index == 0
                                    {
                                        
                                    }
                                    else
                                    {
                                        Auth.auth().currentUser?.sendEmailVerification{ (error) in
                                            
                                            if let error = error {
                                                self.showMessagePrompt(error.localizedDescription)
                                                return
                                            }

                                        }

                                    }
                                }
                            }
                            else
                            {
                                let uid = user.uid
                                let email = user.email
                                let photoURL = user.photoURL
                                print("user id: \(uid) user email: \(String(describing: email)) user photourl: \(String(describing: photoURL))")
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.goToMainViewController()
                            }

                        }

                        
                    }
                }
            }
                // [END headless_email_auth]
            
        } else {
            self.showMessagePrompt(title:"Alert",message: "email/password can't be empty")
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
    
    func verifyEmailAddress(){
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            if let error = error {
                self.showMessagePrompt(title: "error",message:error.localizedDescription)
                return
            }
            
            let user = Auth.auth().currentUser
            self.showMessagePrompt(title: "Verification Email", message: "iOptic has sent an verification email to \(String(describing: user?.email))")

        }
    }
    
    
    @IBAction func skipTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToMainViewController()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

}

