//
//  SignUpVC.swift
//  FireBaseDemo


import UIKit
import Firebase
import EZSwiftExtensions
import FirebaseDatabase

class SignUpVC: CustomNavigationBarViewController {

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
        self.title = NavigationTitle.SignUp
    }
    
    @IBAction func buttonSignUpTapped(_ sender: AnyObject) {
        createUser()
    }
    
    func createUser() {
        if textFieldEmail.text == "" {
            let alertController = UIAlertController(title: AlertConstant.ERROR, message: AlertConstant.ENTER_EMAIL_PASSWORD, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: AlertConstant.OK, style: .cancel, handler: nil)
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
                    let alertController = UIAlertController(title: AlertConstant.ERROR, message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: AlertConstant.OK, style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func navigateToHomeScreen() {
        let storyBoard = UIStoryboard.mainStoryboard
        let homeVC = storyBoard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.HOME_VC) as! HomeVC
        pushVC(homeVC)
    }
    
    
    
    func addUserToFireBaseDB(userEmail: String, userToken: String) {
        let userInfo = [FBUserEnityKey.USER_ID:userToken , FBUserEnityKey.USER_NAME:textFieldUserName.text ?? StringConstant.NOT_PROVIDED, FBUserEnityKey.EMAIL:userEmail] as [String : Any]
        refSignUpUsers.child(FBEntityKey.USERS).child(userToken).setValue(userInfo)
    }
}

