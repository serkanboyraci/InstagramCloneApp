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
        performSegue(withIdentifier: "toFeedVC", sender: nil )
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
}

