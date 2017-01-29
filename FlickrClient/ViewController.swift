//
//  ViewController.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import UIKit
import SDWebImage
import ESPullToRefresh
import DateTools
import BFRImageViewer

class ViewController: UITableViewController {
    var currentPage = 1
    var photos: [Photo] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        PhotoManager.sharedInstance.getRecentPhotos(currentPage, { (photos) in
            self.photos = photos
            self.tableView.reloadData()
            self.currentPage += 1
        }) { (message) in
            
        }
    }
    
    private func initViews() {
        self.view.backgroundColor = UIColor.white
        self.title = "Flickr"
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        self.tableView.register(ImageHeaderView.self, forHeaderFooterViewReuseIdentifier: "imageHeader")
        self.tableView.estimatedRowHeight = self.view.frame.width
        self.tableView.rowHeight = UITableViewAutomaticDimension
        _ = self.tableView.es_addPullToRefresh {
            PhotoManager.sharedInstance.getRecentPhotos(1, { (photos) in
                self.photos = photos
                self.tableView.reloadData()
                self.tableView.es_resetNoMoreData()
                self.tableView.es_stopPullToRefresh()
                self.currentPage += 1
            }) { (message) in
                
            }
        }
        
        _ = self.tableView.es_addInfiniteScrolling {
            PhotoManager.sharedInstance.getRecentPhotos(self.currentPage, { (photos) in
                //Recent images are changing every second so we can filter by ID but it takes O(N) time.
                //OR we can use NSDictionary to filter photos. But I don't filter for this version.
                self.photos.append(contentsOf: photos)
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
                self.currentPage += 1
            }) { (message) in
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if searchController.isActive {
            self.tableView.es_removeRefreshFooter()
            self.tableView.es_removeRefreshHeader()
            self.tableView.separatorStyle = .none
            self.tableView.tableFooterView?.isHidden = true
            
            return 0
            
        } else {
//            self.tableView.es_startPullToRefresh()
//            self.tableView.add
            self.tableView.separatorStyle = .singleLine
            self.tableView.tableFooterView?.isHidden = false
        }
        return self.photos.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let photo = photos[section]
        let headerView = ImageHeaderView(reuseIdentifier: "imageHeader")
        headerView.profileNameLabel.text = photo.owner!.realName
        let uploadDate: NSDate = NSDate(timeIntervalSince1970: photo.uploadTime.timeIntervalSince1970)
        headerView.timeLabel.text = uploadDate.timeAgoSinceNow()
        let imageUrl = PhotoManager.sharedInstance.getBuddiesURL(owner: photo.owner)
        headerView.profileImageView.sd_setImage(with: URL(string: imageUrl))
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.section]
        let imageVC = BFRImageViewController(imageSource: [PhotoManager.sharedInstance.getPhotoURL(photo: photo)])
        self.present(imageVC!, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photos[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        cell.customImageView.sd_setImage(with: URL(string: PhotoManager.sharedInstance.getPhotoURL(photo: photo)))
        return cell
    }


}

extension ViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
   
    }
    
}
