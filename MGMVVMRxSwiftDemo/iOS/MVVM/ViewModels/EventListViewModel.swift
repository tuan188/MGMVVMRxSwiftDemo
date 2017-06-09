//
//  EventListViewModel.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/8/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

class EventListViewModel {
    let repoService: RepoServiceProtocol
    let bag = DisposeBag()
    
    // MARK: - Input
    private(set) var repo: Variable<Repo>
    
    // MARK: - Output
    private(set) var eventList: Variable<[Event]>
    
    init(repoService: RepoServiceProtocol, repo: Variable<Repo>) {
        self.repoService = repoService
        self.repo = repo
        
        self.eventList = Variable<[Event]>([])
        
        bindOutput()
    }
    
    private func bindOutput() {
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
