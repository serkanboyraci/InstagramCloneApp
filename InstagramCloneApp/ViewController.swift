//
//  ViewController.swift
//  InstagramCloneApp
//
//  Created by Ali serkan Boyracı  on 12.03.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
    }


    @IBAction func signInClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in // to creaate a user
                
                if error != nil {
                    self.makeAlert(alerttitle: "Error", alertmessage: error?.localizedDescription ?? "Error!") // to use firebase error message we use localizeddescription
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            makeAlert(alerttitle: "Error", alertmessage: "Username/Password?")
        }
        
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(alerttitle: "Error", alertmessage: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            makeAlert(alerttitle: "Error", alertmessage: "Username/Password not found.")
        }
    }
    
    func makeAlert (alerttitle: String, alertmessage: String) {
        let alert = UIAlertController(title: alerttitle, message: alertmessage, preferredStyle: .alert)
        let okBUtton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBUtton)
        self.present(alert, animated: true, completion: nil)
    }
}

