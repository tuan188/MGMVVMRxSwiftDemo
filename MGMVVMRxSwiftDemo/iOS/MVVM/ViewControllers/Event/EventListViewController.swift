//
//  EventListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/7/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    fileprivate let bag = DisposeBag()
    fileprivate var navigator: Navigator!
    
    private var viewModel: EventListViewModel!
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: EventListViewModel) -> EventListViewController {
        let controller = storyboard.instantiateViewController(ofType: EventListViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: EventCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: EventCell.cellIdentifier)
        tableView.rowHeight = 42

        bindUI()
    }

    private func bindUI() {
        viewModel.repo
            .asObservable()
            .subscribe(onNext: { [weak self] (repo) in
                self?.title = repo.name
            })
            .disposed(by: bag)
        
        viewModel
            .eventList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.cellIdentifier, for: indexPath)
                self?.config(cell, at: indexPath)
                return cell
            }
            .disposed(by: bag)
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? EventCell {
            cell.event = viewModel.eventList.value[indexPath.row]
        }
    }

}
