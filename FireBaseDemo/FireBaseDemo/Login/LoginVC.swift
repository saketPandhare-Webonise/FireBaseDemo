//
//  LoginVC.swift
//  FireBaseDemo

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import Firebase

class LoginVC: UIViewController {

    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonLoginTapped(_ sender: AnyObject) {
        loginButtonTapped()
    }
    
    func loginButtonTapped() {
        if self.textFieldEmail.text == "" || self.textFieldPassword.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            UIHelper.startLoadingIndicator(view: self.view)
            Auth.auth().signIn(withEmail: self.textFieldEmail.text!, password: self.textFieldPassword.text!) { (user, error) in
                if error == nil {
                    print("User ID \(user?.uid)")
                    self.navigateToHomeScreen()
                } else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func buttonFaceBookTapped(_ sender: AnyObject) {
        loginWithFaceBook()
    }

    func loginWithFaceBook() {
         UIHelper.startLoadingIndicator(view: self.view)
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                self.navigateToHomeScreen()
            })
            
        }
    }
    
    func navigateToHomeScreen() {
        UIHelper.stopLoadingIndicator(view: self.view)
        let storyBoard = UIStoryboard.mainStoryboard
        let homeVC = storyBoard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        pushVC(homeVC)
    }
}
