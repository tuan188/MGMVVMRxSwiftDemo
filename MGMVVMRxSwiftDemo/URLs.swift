//
//  URLs.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit

struct URLs {
    static let repoList = "https://api.github.com/search/repositories?q=language:swift&per_page=10"
    //    static let repoList = "https://api.github.com/search/repo"
    static let eventList = "https://api.github.com/repos/%@/events?per_page=5"
}
