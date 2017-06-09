//
//  RepoListViewModel.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/7/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

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
    private(set) var isLoadingData = Variable(false)
    
    init(repoService: RepoServiceProtocol) {
        self.repoService = repoService
        
        self.repoList = Variable<[Repo]>([])
        
        bindOutput()
    }
    
    private func bindOutput() {
        loadDataAction = Action { [weak self] sender in
            print(sender)
            self?.isLoadingData.value = true
            guard let this = self else { return Observable.never() }
            return this.repoService.repoList(input: RepoListInput())
                .map({ (output) -> [Repo] in
                    return output.repositories ?? []
                })
        }
        
        loadDataAction
            .elements
            .subscribe(onNext: { [weak self] (repoList) in
                self?.repoList.value = repoList
                self?.isLoadingData.value = false
            })
            .disposed(by: bag)
        
        loadDataAction
            .errors
            .subscribe(onError: { [weak self](error) in
                self?.isLoadingData.value = false
                print(error)
            })
            .disposed(by: bag)
    }
}
