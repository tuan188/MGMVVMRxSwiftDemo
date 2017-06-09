//
//  RepoCell.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import Kingfisher

class RepoCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var folkLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    var repo: Repo! {
        didSet {
            guard let repo = repo else { return }
            nameLabel.text = repo.name
            starLabel.text = String(repo.starCount)
            folkLabel.text = String(repo.folkCount)
            
            if let url = URL(string: repo.avatarURLString ?? "") {
                avatarImageView.kf.setImage(with:  url)
            }
        }
    }
}
