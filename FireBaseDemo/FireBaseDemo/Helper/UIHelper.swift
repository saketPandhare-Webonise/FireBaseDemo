//
//  UIHelper.swift
//  FireBaseDemo

import UIKit

class UIHelper {

    static func startLoadingIndicator(view: UIView) {
        let spinnerActivity = MBProgressHUD.showAdded(to:view, animated: true);
        
        spinnerActivity.label.text = "Loading";
        
        spinnerActivity.detailsLabel.text = "Please Wait!!"
        
        spinnerActivity.isUserInteractionEnabled = false;
    }
    
    static func stopLoadingIndicator(view: UIView) {
        MBProgressHUD.hideAllHUDs(for: view, animated: true);
    }
    
}
