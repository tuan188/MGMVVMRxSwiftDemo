//
//  RepoService.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift

class RepoService: APIService {
    func repoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return self.request(input)
            .observeOn(MainScheduler.instance)
    }
    
    func eventList(input: EventListInput) -> Observable<EventListOutput> {
        return self.requestArray(input)
            .observeOn(MainScheduler.instance)
            .map { events -> EventListOutput in
                return EventListOutput(events: events)
            }
    }
}
