//
//  RepoListViewModelTests.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import MVVM

class RepoListViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    func test_whenInitialized_storesInitParams() {
        let viewModel = RepoListViewModel(repoService: MockRepoService())
        
        XCTAssertNotNil(viewModel.repoService)
        XCTAssertNotNil(viewModel.repoList)
    }
    
    func test_get_repoList() {
        let asyncExpect = expectation(description: "fulfill test")
        
        let viewModel = RepoListViewModel(repoService: MockRepoService())
        
        XCTAssertEqual(viewModel.repoList.value.count, 0)
        
        viewModel.loadDataAction
            .execute("Test")
            .subscribe(onNext: { _ in
                asyncExpect.fulfill()
            })
            .disposed(by: bag)
        
        waitForExpectations(timeout: 1.0, handler: { error in
            XCTAssertNil(error, "error: \(error!.localizedDescription)")
            XCTAssertEqual(viewModel.repoList.value.count, 2)
        })
    }
    

}
