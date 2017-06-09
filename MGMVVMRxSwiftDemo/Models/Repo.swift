//
//  Repo.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/4/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import ObjectMapper

struct Repo: Mappable {
    var id = 0
    var name: String?
    var fullname: String?
    var urlString: String?
    var starCount = 0
    var folkCount = 0
    var avatarURLString: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullname <- map["full_name"]
        urlString <- map["html_url"]
        starCount <- map["stargazers_count"]
        folkCount <- map["forks"]
        avatarURLString <- map["owner.avatar_url"]
    }
}
