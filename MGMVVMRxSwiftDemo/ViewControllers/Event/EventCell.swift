//
//  EventCell.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class EventCell: UITableViewCell {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    
    var event = Variable<Event?>(nil)
    let bag = DisposeBag()
    
    static var cellIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        event
            .asObservable()
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self](event) in
                guard let event = event else { return }
                self?.typeLabel.text = event.type
                if let url = URL(string: event.avatarURLString ?? "") {
                    self?.avatarImageView.kf.setImage(with: url)
                }
            })
            .disposed(by: bag)
    }

}
