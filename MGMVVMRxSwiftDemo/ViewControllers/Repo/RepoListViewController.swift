//
//  RepoListViewController.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift

class RepoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let service = APIService()
    let bag = DisposeBag()
    
    var repoList = [Repo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        service.repoList(input: RepoListInput())
            .subscribe(onNext: { [weak self] (output) in
                self?.repoList = output.repositories ?? []
                self?.tableView.reloadData()
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: bag)
    }

}

// MARK: - UITableViewDataSource
extension RepoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension RepoListViewController: UITableViewDelegate {
    
}


