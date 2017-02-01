//
//  FBImagePickerDelegate.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

/// The official delegate of the FBImagePicker®
protocol FBImagePickerDelegate: NSObjectProtocol {
    
    /// Called when the user has selected an image from the image picker.
    ///
    /// - Parameter image: The image the user selected
    func fbImagePicker(imageSelected image: UIImage?)
    
}
