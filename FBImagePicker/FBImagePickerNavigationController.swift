//
//  FBImagePickerNavigationController.swift
//  Testing
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class FBImagePickerNavigationController: UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return FBImagePicker.Settings.statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = FBImagePicker.Settings.navTintColor
        navigationBar.barTintColor = FBImagePicker.Settings.navBarTintColor
        navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: FBImagePicker.Settings.navBarTextColor
        ]
    }
    
}
