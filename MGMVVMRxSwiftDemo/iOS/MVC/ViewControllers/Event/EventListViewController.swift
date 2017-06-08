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
    
    private var eventList = Variable<[Event]>([])
    var repo: Variable<Repo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: EventCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: EventCell.cellIdentifier)
        
        eventList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath)
                self?.config(cell, at: indexPath)
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Event.self)
            .filter { $0.type != nil }
            .subscribe(onNext: { [weak self](event) in
                let alertController = UIAlertController(title: nil, message: event.type! + " was selected", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self?.present(alertController, animated: true, completion: nil)
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
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? EventCell {
            cell.event = eventList.value[indexPath.row]
        }
    }
    
}
