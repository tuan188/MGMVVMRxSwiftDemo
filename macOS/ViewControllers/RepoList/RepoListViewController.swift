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
        // Do view setup here.
    }
    
}
