//
//  ViewController.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UITableViewController {
    
    var searchController: UISearchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        self.view.backgroundColor = UIColor.white
        self.title = "Flickr"
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        self.tableView.estimatedRowHeight = self.view.frame.width
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Test"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        cell.customImageView.sd_setImage(with: URL(string: "https://i.ytimg.com/vi/lE6RYpe9IT0/maxresdefault.jpg"))
        return cell
    }


}

