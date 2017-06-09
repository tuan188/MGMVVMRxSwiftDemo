//
//  RepoListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class RepoListViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    
    let bag = DisposeBag()
    var navigator: Navigator!
    
    fileprivate var viewModel: RepoListViewModel!
    
    static func createWith(navigator: Navigator, storyboard: NSStoryboard, viewModel: RepoListViewModel) -> RepoListViewController {
        let controller = storyboard.instantiateViewController(ofType: RepoListViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bindUI()
        
        viewModel.loadDataAction.execute("Fist load")
    }
    
    private func bindUI() {
        viewModel.repoList
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
extension RepoListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.repoList.value.count
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
}

// MARK: - NSTableViewDelegate
extension RepoListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.dequeueCell(ofType: RepoCell.self)
        cell.repo = viewModel.repoList.value[row]
        return cell
    }
}
