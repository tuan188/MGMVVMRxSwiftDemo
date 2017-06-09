//
//  RepoList.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import ObjectMapper

class RepoListInput: APIInput {
    init() {
        super.init(urlString: URLs.repoList,
                   parameters: nil,
                   requestType: .get)
    }
}

class RepoListOutput: APIOutput, Mappable {
    
    var repositories: [Repo]?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        repositories <- map["items"]
    }
}
