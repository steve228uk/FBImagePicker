//
//  FBAlbumViewController.swift
//  FBImagePicker
//
//  Created by Stephen Radford on 01/02/2017.
//  Copyright © 2017 Cocoon Development Ltd. All rights reserved.
//

import UIKit

open class FBAlbumViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    internal var album: FBAlbum?
    fileprivate var images = [FBImage]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavBar()
        loadPhotos()
    }
    
    /// Setup the navigation bar
    fileprivate func setupNavBar() {
        let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePicker))
        navigationItem.setRightBarButton(item, animated: false)
        title = album?.name
    }
    
    /// Close the picker
    public func closePicker() {
        dismiss(animated: true, completion: nil)
    }
    
    /// Load the photos from the album
    fileprivate func loadPhotos() {
        album?.getPhotos { [unowned self] images, error in
            self.images = images
            self.collectionView.reloadData()
        }
    }
    
}

extension FBAlbumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! FBPhotoCollectionViewCell
        cell.image = images[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: (width/4)-0.75, height: (width/4)-0.5)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = self.collectionView.cellForItem(at: indexPath) as? FBPhotoCollectionViewCell else { return }
        dismiss(animated: true) { [unowned cell] in
            FBImagePicker.delegate?.fbImagePicker(imageSelected: cell.photo.image)
        }
    }
    
}
