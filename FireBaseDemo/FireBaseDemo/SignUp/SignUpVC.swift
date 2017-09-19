//
//  SignUpVC.swift
//  FireBaseDemo


import UIKit
import Firebase
import EZSwiftExtensions
import FirebaseDatabase

class SignUpVC: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldUserName: UITextField!
    
    var refSignUpUsers: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        refSignUpUsers = Database.database().reference()
        
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
                    self.addUserToFireBaseDB(userEmail: (user?.email)!, userToken: (user?.uid)!)
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
    
    
    
    func addUserToFireBaseDB(userEmail: String, userToken: String) {
        let userInfo = ["id":userToken , "user_name":textFieldUserName.text ?? "Not Provided", "email":userEmail ,] as [String : Any]
        refSignUpUsers.child("Users").child(userToken).setValue(userInfo)
    }
}

