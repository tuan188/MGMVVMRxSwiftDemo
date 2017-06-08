//
//  Navigator.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/8/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwinjectStoryboard

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - segues list
    enum Segue {
        case repoList
        case eventList(repo: Variable<Repo>)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .repoList:
            let viewModel = RepoListViewModel(repoService: SwinjectStoryboard.defaultContainer.resolve(RepoServiceProtocol.self)!)
            show(target: RepoListViewController.createWith(navigator: self, storyboard: defaultStoryboard, viewModel: viewModel), sender: sender)
        case .eventList(let repo):
            let viewModel = EventListViewModel(repoService: SwinjectStoryboard.defaultContainer.resolve(RepoServiceProtocol.self)!, repo: repo)
            show(target: EventListViewController.createWith(navigator: self, storyboard: defaultStoryboard, viewModel: viewModel), sender: sender)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            nav.pushViewController(target, animated: false)
        } else if let nav = sender.navigationController {
            nav.pushViewController(target, animated: true)
        }
    }
    
    private func present(target: UIViewController, sender: UIViewController) {
        sender.present(target, animated: true, completion: nil)
    }
}
