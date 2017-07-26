//
//  EventList.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import ObjectMapper

class EventListInput: APIInputBase {
    init(repoFullName: String) {
        super.init(urlString: String(format: URLs.eventList, repoFullName),
                   parameters: nil,
                   requestType: .get)
    }
}

class EventListOutput: APIOutputBase {
    var events = [Event]()
    
    init(events: [Event]) {
        self.events = events
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
