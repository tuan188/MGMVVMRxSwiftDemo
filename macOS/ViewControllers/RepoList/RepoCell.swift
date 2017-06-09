//
//  RepoCell.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Cocoa
import Kingfisher

class RepoCell: NSTableCellView {
    
    @IBOutlet var avatarImageView: NSImageView!
    @IBOutlet var nameLabel: NSTextField!
    @IBOutlet var starLabel: NSTextField!
    @IBOutlet var folkLabel: NSTextField!
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    var repo: Repo! {
        didSet {
            guard let repo = repo else { return }
            nameLabel.stringValue = repo.name ?? ""
            starLabel.stringValue = "Star: " + String(repo.starCount)
            folkLabel.stringValue = "Folk: " + String(repo.folkCount)
            
            if let url = URL(string: repo.avatarURLString ?? "") {
                avatarImageView.kf.setImage(with:  url)
            }
        }
    }
}
