//
//  RepoListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/7/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepoListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    fileprivate let bag = DisposeBag()
    fileprivate var navigator: Navigator!
    
    fileprivate var viewModel: RepoListViewModel!
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: RepoListViewModel) -> RepoListViewController {
        let controller = storyboard.instantiateViewController(ofType: RepoListViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Repo List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
        tableView.register(UINib(nibName: RepoCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: RepoCell.cellIdentifier)
        tableView.rowHeight = 92
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.addSubview(refreshControl)

        bindUI()
        
        viewModel.loadDataAction.execute("First load")
    }
    
    private func bindUI() {
        self.navigationItem.rightBarButtonItem!.rx
            .bind(to: viewModel.loadDataAction) { _ in return "Refresh button" }
        
        viewModel
            .repoList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.cellIdentifier, for: indexPath)
                self?.config(cell, at: indexPath)
                return cell
            }
            .disposed(by: bag)
        
        viewModel.isLoadingData
            .asDriver()
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Repo.self)
            .subscribe(onNext: { [weak self](repo) in
                guard let this = self else { return }
                self?.navigator.show(segue: .eventList(repo: Variable(repo)), sender: this)
            })
            .disposed(by: bag)
        
        refreshControl.rx
            .bind(to: viewModel.loadDataAction, controlEvent: refreshControl.rx.controlEvent(.valueChanged)) { _ in
                return "Refresh button"
        }
        
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? RepoCell {
            cell.repo = viewModel.repoList.value[indexPath.row]
        }
    }
}
