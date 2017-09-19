//
//  HomeVC.swift
//  FireBaseDemo


import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class HomeVC: UIViewController {
    var loggeInUserName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = loggeInUserName
    }
    
    @IBAction func buttonLogOutTapped(_ sender: AnyObject) {
        logOutUser()
    }
    
    
    /// This function is used to logout user
    func logOutUser() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                navigatToRootController()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func navigatToRootController() {
        popToRootVC()
    }
    
    
    @IBAction func buttonUploadImage(_ sender: Any) {
        uploadMedia(completion: {(photoUrl) in
            print("photo URL has \(String(describing: photoUrl))")
      })
    }
    
    /// This function is used to upload image 
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("myImage.png")
        if let uploadData = UIImageJPEGRepresentation(UIImage.init(named: "HomeScreen")!, 0.8) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    completion((metadata?.downloadURL()?.absoluteString)!)
                    // your uploaded photo url.
                }
            }
        }
    }
}
