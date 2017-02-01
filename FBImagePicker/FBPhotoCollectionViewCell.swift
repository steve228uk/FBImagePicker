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
    
    override func prepareForReuse() {
        photo.image = nil
    }
    
}
