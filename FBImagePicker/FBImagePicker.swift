//
//  FBImagePicker.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import Foundation
import FBSDKCoreKit

public class FBImagePicker {
    
    private init() { }
    
    /// Load albums from the Facebook API
    ///
    /// - Parameter completionHandler: The response handler
    public class func getAlbums(completionHandler: @escaping ([FBAlbum], String?, Error?) -> Void) {
        FBSDKGraphRequest(graphPath: "me/albums", parameters: ["fields": ""], httpMethod: "GET")
            .start { connection, result, error in        
                if let error = error {
                    completionHandler([], nil, error)
                    return
                }
                
                guard let dict = result as? [String:Any], let albums = dict["data"] as? [[String:Any]] else {
                    completionHandler([], nil, FBImagePickerError.parseJSONError)
                    return
                }
                
                let nextPage = (dict["paging"] as? [String:AnyObject])?["next"] as? String
                completionHandler(albums.map(FBAlbum.init), nextPage, nil)
            }
    }
    
}
