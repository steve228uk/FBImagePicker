//
//  FBImagePicker.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import Foundation
import FBSDKCoreKit

/// The main class for the image picker. Set your delegate and any settings here.
public class FBImagePicker {

    private init() { }

    /// The delegate that will be called when an image is selected
    static weak var delegate: FBImagePickerDelegate?

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
                    completionHandler([], nil, FBImagePickerError.parseJSON)
                    return
                }

                let nextPage = (dict["paging"] as? [String:AnyObject])?["next"] as? String
                completionHandler(albums.map(FBAlbum.init), nextPage, nil)
        }
    }

    /// Present the image picker on the view controller defined here.
    ///
    /// - Parameter viewController: The view controller to present the image picker on.
    public class func present(on viewController: UIViewController) {
        var bundle = Bundle(for: self)
        if let bundleURL = bundle.url(forResource: "FBImagePicker-Resources", withExtension: "bundle") {
            guard let resourceBundle = Bundle(url: bundleURL) else { return }
			bundle = resourceBundle
        }

        guard let vc = UIStoryboard(name: "FBImagePicker", bundle: Bundle(for: self)).instantiateInitialViewController() else { return }
        viewController.present(vc, animated: true, completion: nil)
    }

    /// User settings are defined here
    struct Settings {

        /// The title to be displayed in the navigation bar on the album selection screen.
        static var albumsTitle = "Facebook Albums"

        static var noAlbumsText = "No Albums"

        static var noImagesText = "No Images"

        /// The style the status bar should be in the image picker
        static var statusBarStyle = UIStatusBarStyle.lightContent

        static var navTintColor = UIColor.white

        static var navBarTintColor = UIColor(hue:0.61, saturation:0.60, brightness:0.59, alpha:1.00)

        static var navBarTextColor = UIColor.white

        static var imageTransitionDuration = 0.0

        static var infiniteScrollOffset: CGFloat = 200

    }

}
