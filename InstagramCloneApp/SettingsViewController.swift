//
//  SettingsViewController.swift
//  InstagramCloneApp
//
//  Created by Ali serkan Boyracı  on 12.03.2024.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
     @IBAction func logOutClicked(_ sender: Any) {
         do {
             try Auth.auth().signOut() // to logout last call
             self.performSegue(withIdentifier: "toViewController", sender: nil)
         } catch {
             print("Erroorr")
         }
         
     }
     

}
