//
//  HomeVC.swift
//  FireBaseDemo


import UIKit
import Firebase
import FirebaseAuth

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonLogOutTapped(_ sender: AnyObject) {
        logOutUser()
    }
    
    
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
}
