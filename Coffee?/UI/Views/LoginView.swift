//
//  LoginView.swift
//  Coffee?
//
//  Created by Jimmy Yue on 3/28/16.
//  Copyright © 2016 Jimmy Yue. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var foursquareLabel1: UILabel!
    @IBOutlet weak var forLabel: UILabel!
    @IBOutlet weak var foursquareLabel2: UILabel!
    @IBOutlet weak var loginButton: LoginWithFacebook!
    
    var view: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        xibSetup()
    }
    
    // MARK: - View Linking
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        loadInView()
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LoginView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    private func loadInView() {
        logo.alpha = 0
        foursquareLabel1.alpha = 0
        forLabel.alpha = 0
        foursquareLabel2.alpha = 0
        loginButton.alpha = 0
        loginButton.cellButton.enabled = false
        
        // Ugly animation block - TODO: - Use third party library to clean up
        UIView.animateWithDuration(0.5, animations: {
            self.logo.alpha = 1.0
            }, completion: { Void in
                UIView.animateWithDuration(0.5, animations: {
                    self.foursquareLabel1.alpha = 1.0
                    }, completion: { Void in
                        UIView.animateWithDuration(0.5, animations: {
                            self.forLabel.alpha = 1.0
                            }, completion: { Void in
                                UIView.animateWithDuration(0.5, animations: {
                                    self.foursquareLabel2.alpha = 1.0
                                    }, completion: { Void in
                                        UIView.animateWithDuration(0.5, animations: {
                                            self.loginButton.alpha = 1.0
                                            self.loginButton.cellButton.enabled = true
                                        })
                                })
                        })
                })
            })
    }


}
