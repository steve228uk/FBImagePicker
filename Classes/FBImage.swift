//
//  FBImage.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import Alamofire

open class FBImage {
    
    public let url: String
    
    public var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    public func getImage(completionHandler: @escaping (UIImage?) -> Void) {
        guard image == nil else {
            completionHandler(image)
            return
        }
        
        Alamofire.request(url)
            .responseData { [unowned self] response in
                guard let data = response.value else { return }
                self.image = UIImage(data: data)
                completionHandler(self.image)
            }
    }
    
}
