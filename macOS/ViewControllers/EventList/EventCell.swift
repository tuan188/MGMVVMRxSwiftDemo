//
//  EventCell.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Cocoa
import Kingfisher

class EventCell: NSTableCellView {
    
    @IBOutlet var avatarImageView: NSImageView!
    @IBOutlet var typeLabel: NSTextField!
    
    var event: Event! {
        didSet {
            typeLabel.stringValue = event.type ?? ""
            if let url = URL(string: event.avatarURLString ?? "") {
                avatarImageView.kf.setImage(with: url)
            }
        }
    }
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
