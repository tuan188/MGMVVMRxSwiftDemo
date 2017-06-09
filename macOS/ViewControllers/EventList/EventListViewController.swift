//
//  EventListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class EventListViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    
    let bag = DisposeBag()
    var navigator: Navigator!
    
    fileprivate var viewModel: EventListViewModel!
    
    static func createWith(navigator: Navigator, storyboard: NSStoryboard, viewModel: EventListViewModel) -> EventListViewController {
        let controller = storyboard.instantiateViewController(ofType: EventListViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bindUI()
    }
    
    private func bindUI() {
        viewModel
            .eventList
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: bag)
    }
}

// MARK: - NSTableViewDataSource
extension EventListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.eventList.value.count
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 42
    }
}

// MARK: - NSTableViewDelegate
extension EventListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.dequeueCell(ofType: EventCell.self)
        cell.event = viewModel.eventList.value[row]
        return cell
    }
}
