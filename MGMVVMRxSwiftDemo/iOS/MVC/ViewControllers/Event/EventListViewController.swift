//
//  EventListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var repoService: RepoServiceProtocol!
    let bag = DisposeBag()
    
    fileprivate var eventList = Variable<[Event]>([])
    var repo: Variable<Repo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: EventCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: EventCell.cellIdentifier)
        
        eventList.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: bag)
        
        repo
            .asObservable()
            .subscribe(onNext: { [weak self](repo) in
                self?.title = repo.name
            })
            .disposed(by: bag)

        repo
            .asObservable()
            .filter { $0.fullname != nil && !$0.fullname!.isEmpty }
            .map { $0.fullname! }
            .flatMap({ repoFullName -> Observable<EventListOutput> in
                return self.repoService.eventList(input: EventListInput(repoFullName: repoFullName))
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
            cell.event = eventList.value[indexPath.row]
        }
    }
    
}

// MARK: - UITableViewDelegate
extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
}
