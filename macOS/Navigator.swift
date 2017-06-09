//
//  Navigator.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Foundation
import Cocoa
import RxCocoa
import RxSwift

class Navigator {
    lazy private var defaultStoryboard = NSStoryboard(name: "Main", bundle: nil)
    
    // MARK: - segues list
    enum Segue {
        case repoList
        case eventList(repo: Variable<Repo>)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: NSViewController) {
        switch segue {
        case .repoList:
            let vm = RepoListViewModel(repoService: RepoService())
            show(target: RepoListViewController.createWith(navigator: self, storyboard: defaultStoryboard, viewModel: vm), sender: sender)
        case .eventList(let repo):
            let vm = EventListViewModel(repoService: RepoService(), repo: repo)
            if let replaceableSender = (sender.parent as? NSSplitViewController)?.childViewControllers.last {
                show(target: EventListViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: replaceableSender)
            } else {
                show(target: EventListViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: sender)
            }
            break
        }
    }
    
    private func show(target: NSViewController, sender: NSViewController) {
        if let split = sender as? NSSplitViewController {
            split.addChildViewController(target)
        }
        
        if let split = sender.parent as? NSSplitViewController,
            let index = split.childViewControllers.index(of: sender) {
            split.childViewControllers.replaceSubrange(index...index, with: [target])
        }
    }
}
