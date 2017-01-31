//
//  FBAlbum.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import Foundation
import FBSDKCoreKit

/// Represents an album on Facebook
open class FBAlbum {
    
    /// The display name of the album
    public let name: String
    
    /// The ID of the Facebook album
    public let id: String
    
    /// The URL of cover photo for the album
    public var coverURL: String {
        return "https://graph.facebook.com/v2.8/\(id)/picture?type=thumbnail&access_token=\(FBSDKAccessToken.current().tokenString)"
    }
    
    /// Endpoint that's used to fetch photos for the album
    private var photosURL: String {
        return "\(id)/photos"
    }
    
    /// The next page to load
    private var nextPage: String?
    
    /// Construct a new Facebook album from JSON retreived from the API
    ///
    /// - Parameter json: The JSON object received from the API
    init(json: [String:Any]) {
        name = json["name"] as? String ?? ""
        id = json["id"] as? String ?? ""
    }
    
    /// Get photos for the album from the Graph API
    ///
    /// - Parameter completionHandler: The response handler
    func getPhotos(completionHandler: @escaping ([String], Error?) -> Void) {
        
        FBSDKGraphRequest(graphPath: photosURL, parameters: ["fields": ""], httpMethod: "GET")
            .start { request, result, error in
                if let error = error {
                    completionHandler([], error)
                }
                
                guard let dict = result as? [String:Any], let photos = dict["data"] as? [[String:Any]] else {
                    completionHandler([], FBImagePickerError.parseJSONError)
                    return
                }
                
                self.nextPage = (dict["paging"] as? [String:Any])?["next"] as? String
                
                let mapped = photos.map { json in
                    return "https://graph.facebook.com/v2.8/\(json["id"] as! String)/picture?access_token=\(FBSDKAccessToken.current().tokenString)"
                }
                
                completionHandler(mapped, nil)
            }
        
    }
    
//    func getNext(completionHandler: ([String]) -> Void) {
//        
//        guard let next = nextPage else {
//            completionHandler([])
//            return
//        }
//        
//        Alamofire.request(.GET, next)
//            .responseJSON { response in
//                guard let dict = response.result.value as? [String:AnyObject] else {
//                    completionHandler([])
//                    return
//                }
//                
//                guard let photos = dict["data"] as? [[String:AnyObject]] else {
//                    completionHandler([])
//                    return
//                }
//                
//                self.nextPage = (dict["paging"] as? [String:AnyObject])?["next"] as? String
//                
//                let mapped = photos.map { json in
//                    return "https://graph.facebook.com/v2.8/\(json["id"] as! String)/picture?access_token=\(FBSDKAccessToken.currentAccessToken().tokenString)"
//                }
//                
//                completionHandler(mapped)
//                
//        }
//    }
    
}
