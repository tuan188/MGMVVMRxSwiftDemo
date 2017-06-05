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
    var repo: Variable<Repo>!
    
    let repoService = RepoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: EventCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: EventCell.cellIdentifier)
        
        eventList
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: bag)

        repo
            .asObservable()
            .filter { $0.fullname != nil && !$0.fullname!.isEmpty }
            .flatMap({ (repo) -> Observable<EventListOutput> in
                return self.repoService.eventList(input: EventListInput(repoFullName: repo.fullname!))
            })
            .subscribe(onNext: { [weak self] (output) in
                self?.eventList.value = output.events
            }, onError: { (error) in
                print(error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath)
        config(cell, at: indexPath)
        return cell
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? EventCell {
            cell.event.value = eventList.value[indexPath.row]
        }
    }
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    
}
