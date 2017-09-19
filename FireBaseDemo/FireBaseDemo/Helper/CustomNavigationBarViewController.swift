//
//  CustomNavigationBarViewController.swift
//  FireBaseDemo


import UIKit

class CustomNavigationBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "0x01334E")//UIColor(hexValue: 0x01334E)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
    }
   
}
