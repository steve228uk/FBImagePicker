//
//  FBAlbumTableViewCell.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class FBAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    var album: FBAlbum? {
        didSet {
            guard let album = album else { return }
            
            albumNameLabel.text = album.name
            
            // Load the image here
            
//            coverImage.af_setImageWithURL(NSURL(string: album.coverURL)!, imageTransition: .CrossDissolve(0.5), runImageTransitionIfCached: false)
        }
    }
    
    override func prepareForReuse() {
        coverImage.image = nil
    }

}
