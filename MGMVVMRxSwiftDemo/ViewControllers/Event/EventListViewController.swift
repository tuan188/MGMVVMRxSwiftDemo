//
//  EventListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift

class EventListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let bag = DisposeBag()
    var eventList = Variable<[Event]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventList
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: bag)

        
        
    }
}

// MARK: - UITableViewDataSource
extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    
}
