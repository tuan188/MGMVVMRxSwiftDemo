//
//  RepoListViewModel.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/7/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class RepoListViewModel {
    
    let repoService: RepoServiceProtocol
    let bag = DisposeBag()
    
    // MARK: - Input
    
    // MARK: - Output
    private(set) var repoList: Variable<[Repo]>
    private(set) var loadDataAction: Action<String, [Repo]>!
    
    init(repoService: RepoServiceProtocol) {
        self.repoService = repoService
        
        self.repoList = Variable<[Repo]>([])
        
        bindOutput()
    }
    
    private func bindOutput() {
        loadDataAction = Action { [weak self] sender in
            print(sender)
            guard let strongSelf = self else { return Observable.never() }
            return strongSelf.repoService.repoList(input: RepoListInput())
                .map({ (output) -> [Repo] in
                    return output.repositories ?? []
                })
        }
        
        loadDataAction
            .elements
            .subscribe(onNext: { [weak self] (repoList) in
                self?.repoList.value = repoList
            })
            .disposed(by: bag)
        
        loadDataAction
            .errors
            .subscribe(onError: { (error) in
                print(error)
            })
            .disposed(by: bag)
    }
}
