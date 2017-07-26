//
//  RepoList.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import ObjectMapper

class RepoListInput: APIInputBase {
    init() {
        super.init(urlString: URLs.repoList,
                   parameters: nil,
                   requestType: .get)
    }
}

class RepoListOutput: APIOutputBase {
    
    var repositories: [Repo]?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        repositories <- map["items"]
    }
}
