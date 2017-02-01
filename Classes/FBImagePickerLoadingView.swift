//
//  FBImagePickerLoadingView.swift
//  Testing
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

class FBImagePickerLoadingView: UIView {
    
    var loadingIndicator: UIActivityIndicatorView!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) // Did they seriously remove CGRectZero??
        
        backgroundColor = .white
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingIndicator)
        
        addConstraint(NSLayoutConstraint(item: loadingIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loadingIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        loadingIndicator.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.alpha = 0
        }) { [unowned self] completed in
            if completed {
                self.isHidden = true
            }
        }
    }
    
}
