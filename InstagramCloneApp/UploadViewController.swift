//
//  UploadViewController.swift
//  InstagramCloneApp
//
//  Created by Ali serkan Boyracı  on 12.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func chooseImage () { //to go to the photo gallery
        let pickerController = UIImagePickerController()
        pickerController.delegate = self //to use picker functions
        pickerController.sourceType = .photoLibrary // to take data source
        pickerController.allowsEditing = true // to edit photo
        present(pickerController, animated: true, completion: nil)
        
    }
    
    // after selecting photo, to go back VC
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage //you can select .originalImage or editedImage
        //saveButton.isEnabled = true // to save button activated
        self.dismiss(animated: true, completion: nil)  // to close selecting window (picker)
    }
    
    func makeAlert (alerttitle: String, alertmessage: String) {
        let alert = UIAlertController(title: alerttitle, message: alertmessage, preferredStyle: .alert)
        let okBUtton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBUtton)
        self.present(alert, animated: true, completion: nil)
    }
    

  
    @IBAction func uploadButtonClicked(_ sender: Any) {
        let storage = Storage.storage()  // to work with FirebaseStorage, you can see all steps alson in this link.
        let storageReference = storage.reference() // we use this reference as we use this folder.
        
        let mediaFolder = storageReference.child("media") // we reach to media folder which we produce from web. ALso if you do this code, xcode automatically produce this folder. / if you .child("...) you will go one times lower.
        
        // we must change the format of the view, as we have done it artBookApp.
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {  // we decrease the quality
            
            let uuid = UUID().uuidString // uuid to change string, everytime we will get uniqe id strings.
            
            let imageReference = mediaFolder.child("\(uuid).jpg") // before we take only "image.jpg" and, everytime overwrite of it. , we will take jpg format and uuid string name.
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(alerttitle: "Error", alertmessage: error?.localizedDescription ?? "ERROR")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString // means take URL and change it as String
                        
                            
                        // DATABASE
                           // you have to first initialize from firestore database and also you can define key-value pair from there also from xcode.
                            
                            let firestoreDatabase = Firestore.firestore() //similar like Auth.auth() and Storage.storage()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            // we define Post Collection as a Dict // data will be dict string: any
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp() , "likes" : 0,] as [String : Any]
                            
                            // we define a collection from xcode instead of web
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil {
                                    self.makeAlert(alerttitle: "Error", alertmessage: error?.localizedDescription ?? "Error")
                                } else {
                                    // we have to reset upload page.
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    // and go to the feed page
                                    self.tabBarController?.selectedIndex = 0 // 0 means Feed
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
