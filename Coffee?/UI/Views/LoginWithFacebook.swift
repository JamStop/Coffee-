//
//  LoginWithFacebook.swift
//  Coffee?
//
//  Created by Jimmy Yue on 12/6/15.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import Foundation

class LoginWithFacebook: UIButton {
    
    var view: UIView!

    @IBOutlet weak var cellButton: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        xibSetup()
    }
    
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        
        cellButton.titleLabel?.numberOfLines = 1
        cellButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cellButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LoginWithFacebook", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup()
    }
    

    
}

