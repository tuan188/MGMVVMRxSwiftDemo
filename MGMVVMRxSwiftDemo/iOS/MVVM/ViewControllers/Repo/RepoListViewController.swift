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
    
    private let bag = DisposeBag()
    fileprivate var viewModel: RepoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Repo List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
        tableView.register(UINib(nibName: RepoCell.cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: RepoCell.cellIdentifier)
        tableView.delegate = self
        
        self.viewModel = RepoListViewModel(repoService: RepoService())

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
    }
    
    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? RepoCell {
            cell.repo = viewModel.repoList.value[indexPath.row]
        }
    }
}

// MARK: - UITableViewDelegate
extension RepoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
