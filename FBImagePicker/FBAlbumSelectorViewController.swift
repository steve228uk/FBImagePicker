//
//  FBAlbumSelectorViewController.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

open class FBAlbumSelectorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// The albums that have been loaded from Facebook
    fileprivate var albums = [FBAlbum]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        loadAlbums()
    }
    
    /// Setup the navigation bar
    fileprivate func setupNavBar() {
        let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePicker))
        navigationItem.setRightBarButton(item, animated: false)
        title = FBImagePicker.Settings.albumsTitle
    }
    
    fileprivate func loadAlbums() {
        FBImagePicker.getAlbums { [unowned self] albums, nextPage, error in
            self.albums = albums
            self.tableView.reloadData()
            // TODO: Hide the loading view
            // TODO: Show an error message if required
            // TODO: Show a no albums message if required
        }
    }
    
    /// Close the picker
    public func closePicker() {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableView

extension FBAlbumSelectorViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "album") as! FBAlbumTableViewCell
        cell.album = albums[indexPath.row]
        return cell
    }
    
}
