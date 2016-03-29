//
//  LoginViewController.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/28/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var mainView: LoginView!
    var loginErrorAlert: UIAlertController!
    
    // MARK: - Overrides
    override func viewDidLoad() {
        mainView.loginButton.cellButton.addTarget(self, action: "loginWithFacebookButtonPressed:", forControlEvents: .TouchUpInside)
    }
    
    // MARK: - Controller Actions
    

}
