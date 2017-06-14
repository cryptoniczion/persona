//
//  PersonaPhotoViewController.swift
//  persona_1
//
//  Created by Purnima Singh on 12/06/17.
//  Copyright (c) 2017 Purnima Singh. All rights reserved.
//

import UIKit

class PersonaPhotoViewController: UICollectionViewController {
   fileprivate let reuseIdentifier = "PersonaCell"
   fileprivate let sectionInsets   = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50, right: 20)
   
    fileprivate var searches = [FlickrSearchResults]()
    fileprivate let flickr = Flickr()
    


private extension PersonaPhotoViewController {
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as IndexPath).row]
    }
    }}
extension PersonaPhotoViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickrForTerm(textField.text!) {
            results, error in
            
            
            activityIndicator.removeFromSuperview()
            
            
            if let error = error {
                // 2
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // 3
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.insert(results, at: 0)
                
                // 4
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}
    extension PersonaPhotoViewController {
        //1
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return searches.count
        }
        
        //2
        override func collectionView(_ collectionView: UICollectionView,
            numberOfItemsInSection section: Int) -> Int {
                return searches[section].searchResults.count
        }
        
        //3
        override func collectionView(_ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                    for: indexPath)
                cell.backgroundColor = UIColor.black
                // Configure the cell
                return cell
        }
    }
