//
//  SignUpVC.swift
//  FireBaseDemo


import UIKit
import Firebase
import EZSwiftExtensions


class SignUpVC: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    func initialSetUp() {
        self.title = "Sign Up"
    }
    
    @IBAction func buttonSignUpTapped(_ sender: AnyObject) {
        createUser()
    }
    
    func createUser() {
        if textFieldEmail.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            UIHelper.startLoadingIndicator(view: self.view)
            Auth.auth().createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { (user, error) in
                UIHelper.stopLoadingIndicator(view: self.view)
                if error == nil {
                    print("User ID \(user?.providerID)")
                    self.navigateToHomeScreen()
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func navigateToHomeScreen() {
        let storyBoard = UIStoryboard.mainStoryboard
        let homeVC = storyBoard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        pushVC(homeVC)
    }
}

