//
//  LoginViewController.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/28/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mainView: LoginView!
    var loginErrorAlert: UIAlertController!
    let loginHelper = FirebaseLoginHelper()
    let realm = try! Realm()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        mainView.loginButton.cellButton.addTarget(self, action: #selector(LoginViewController.loginWithFacebookButtonPressed), forControlEvents: .TouchUpInside)
    }
    
    // MARK: - Controller Actions
    func loginWithFacebookButtonPressed(sender: UIButton) {
        print("pressed")
        showLoadingIndicator(self.view)
        loginHelper.login(self) { (success) -> Void in
            if success {
                print(success)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let cultureVC = mainStoryboard.instantiateViewControllerWithIdentifier("mapNavigation")
                cultureVC.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                self.presentViewController(cultureVC, animated: true, completion: nil)
                
            }
            else {
                print(success)
                self.hideLoadingIndicator()
                self.presentViewController(self.loginErrorAlert, animated: true, completion: nil)
            }
        }
    }
    
    func showLoadingIndicator(view: UIView){
        LoadingHUD.sharedHUD.showInView(view)
    }
    
    func hideLoadingIndicator(){
        LoadingHUD.sharedHUD.hide()
    }

}
