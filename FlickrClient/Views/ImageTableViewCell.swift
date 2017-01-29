//
//  ImageTableViewCell.swift
//  FlickrClient
//
//  Created by Omer on 29/01/2017.
//  Copyright © 2017 Omer. All rights reserved.
//

import UIKit
import SnapKit

class ImageTableViewCell: UITableViewCell {
    var customImageView: UIImageView! = {
        let customImageView = UIImageView()
        customImageView.clipsToBounds = true
        customImageView.contentMode = .scaleAspectFill
        return customImageView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    private func setupSubviews() {
        contentView.addSubview(customImageView)
        customImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.width.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
