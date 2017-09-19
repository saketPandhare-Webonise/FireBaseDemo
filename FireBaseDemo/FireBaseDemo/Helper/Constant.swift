//
//  Constant.swift
//  FireBaseDemo


import UIKit

typealias StoryBoardIdentifiers = Constant.StoryBoardIdentifierConstant
typealias FBUserEnityKey        = Constant.FBUserEnityKey
typealias FBEntityKey           = Constant.FBEntityKey
typealias NavigationTitle       = Constant.NavigationTitle
typealias AlertConstant         = Constant.AlertConstant
typealias StringConstant        = Constant.StringConstant

class Constant {
    
    class StoryBoardIdentifierConstant {
        static let HOME_VC = "HomeVC"
    }
    
    class FBUserEnityKey {
        static let EMAIL = "email"
        static let USER_ID = "id"
        static let USER_NAME = "user_name"
    }
    
    class FBEntityKey {
        static let USERS = "Users"
    }
    
    class NavigationTitle {
        static let SignUp = "Sign Up"
    }
    
    class StringConstant {
        static let NOT_PROVIDED = "Not Provided"
    }
    
    class AlertConstant {
        static let ERROR = "Error"
        static let ENTER_EMAIL_PASSWORD = "Please enter your email and password"
        static let OK = "OK"
    }
}
