//
//  MockRepoService.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift

@testable import MVVM

class MockRepoService: RepoServiceProtocol {
    
    static let repositories: [Repo] = [
        Repo(name: "RxSwift"),
        Repo(name: "RxCocoa")
    ]
    
    func repoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return Observable.just(MockRepoService.repositories)
            .map({ (repoList) -> RepoListOutput in
                let output = RepoListOutput()
                output.repositories = repoList
                return output
            })
    }
    
    func eventList(input: EventListInput) -> Observable<EventListOutput> {
        fatalError()
    }
}
