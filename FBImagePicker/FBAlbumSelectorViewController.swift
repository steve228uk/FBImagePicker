//
//  FBAlbumSelectorViewController.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 31/01/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import Alamofire

/// This is the first view the user will see in the image picker.
/// It allows them to select an album which will then show them the images in that album for selection.
open class FBAlbumSelectorViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// The albums that have been loaded from Facebook
    fileprivate var albums = [FBAlbum]()
    fileprivate var loading = false
    fileprivate var nextPage: String?
    fileprivate var loadingView: FBImagePickerLoadingView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupNavBar()
        loadAlbums()
        addLoadingView()
    }
    
    func addLoadingView() {
        loadingView = FBImagePickerLoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loadingView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: [], metrics: nil, views: ["subview": loadingView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: [], metrics: nil, views: ["subview": loadingView]))
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return FBImagePicker.Settings.statusBarStyle
    }
    
    /// Setup the navigation bar
    fileprivate func setupNavBar() {
        let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePicker))
        navigationItem.setRightBarButton(item, animated: false)
        title = FBImagePicker.Settings.albumsTitle
    }
    
    /// Load the albums from Facebook into the tableView
    fileprivate func loadAlbums() {
        FBImagePicker.getAlbums { [unowned self] albums, nextPage, error in
            self.albums = albums
            self.tableView.reloadData()
            self.nextPage = nextPage
            self.getNextPage()
            self.loadingView.fadeOut()
            
            // TODO: Hide the loading view
            // TODO: Show an error message if required
            // TODO: Show a no albums message if required
        }
    }
    
    fileprivate func getNextPage() {
        guard let nextPage = nextPage, !loading else { return }
        loading = true
        Alamofire.request(nextPage)
            .responseJSON { [unowned self] response in
                guard let dict = response.value as? [String:Any], let albums = dict["data"] as? [[String:Any]] else { return }
                self.nextPage = (dict["paging"] as? [String:AnyObject])?["next"] as? String
                self.albums += albums.map(FBAlbum.init)
                self.tableView.reloadData()
                self.loading = false
        }
    }
    
    /// Close the picker
    public func closePicker() {
        dismiss(animated: true, completion: nil)
    }
    
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FBAlbumViewController, let indexPath = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: indexPath) as? FBAlbumTableViewCell {
            vc.album = cell.album
            tableView.deselectRow(at: indexPath, animated: true)
        }
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

// MARK: - Infinite Scroll

extension FBAlbumSelectorViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom = scrollView.contentOffset.y + scrollView.frame.size.height
        guard bottom >= scrollView.contentSize.height - FBImagePicker.Settings.infiniteScrollOffset else { return }
        getNextPage()
    }
    
}
