//
//  FBAlbumTableViewCell.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import Alamofire

class FBAlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    var album: FBAlbum? {
        didSet {
            guard let album = album else { return }
            
            albumNameLabel.text = album.name
            
            album.getCoverImage { [unowned self] image in
                UIView.transition(with: self.coverImage, duration: FBImagePicker.Settings.imageTransitionDuration, options: .transitionCrossDissolve, animations: { [unowned self] in
                    self.coverImage.image = image
                }, completion: nil)
            }
        }
    }
    
    override func prepareForReuse() {
        coverImage.image = nil
    }
    
}
