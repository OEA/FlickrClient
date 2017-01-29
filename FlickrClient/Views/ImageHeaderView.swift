//
//  ImageHeaderView.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import UIKit
import SnapKit

class ImageHeaderView: UITableViewHeaderFooterView {
    
    let profileImageView : UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.layer.cornerRadius = 15
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()
    
    let profileNameLabel : UILabel = {
        let profileNameLabel = UILabel()
        profileNameLabel.font = .systemFont(ofSize: 15)
        profileNameLabel.lineBreakMode = .byTruncatingTail
        return profileNameLabel
    }()
    
    let timeLabel : UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        timeLabel.textColor = .lightGray
        return timeLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        self.contentView.backgroundColor = .white
        addProfileImage()
        addTimeLabel()
        addProfileNameLabel()
    }
    
    private func addProfileImage() {
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.leading.equalTo(10)
            make.height.width.equalTo(30)
            make.bottom.equalTo(-10)
        }
    }
    
    private func addProfileNameLabel() {
        contentView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualTo(timeLabel.snp.leading).offset(-5)
            make.centerY.equalTo(profileImageView)
        }
    }
    
    private func addTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
