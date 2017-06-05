//
//  Event.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import ObjectMapper

struct Event: Mappable {
    var id: String?
    var type: String?
    var avatarURLString: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        avatarURLString <- map["actor.avatar_url"]
    }
}
