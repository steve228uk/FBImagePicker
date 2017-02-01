//
//  FBPhotoCollectionViewCell.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class FBPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    var image: FBImage? {
        didSet {
            guard let image = image else { return }
            
            guard let cached = image.image else {
                image.getImage { [unowned self] image in
                    UIView.transition(with: self.photo, duration: FBImagePicker.Settings.imageTransitionDuration, options: .transitionCrossDissolve, animations: { [unowned self] in
                        self.photo.image = image
                        }, completion: nil)
                }
                return
            }
            
            photo.image = cached
        }
    }
    
    override func prepareForReuse() {
        photo.image = nil
    }
    
}
