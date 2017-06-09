//
//  RepoService.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import RxSwift

protocol RepoServiceProtocol {
    func repoList(input: RepoListInput) -> Observable<RepoListOutput>
    func eventList(input: EventListInput) -> Observable<EventListOutput>
}

class RepoService: APIService, RepoServiceProtocol {
    func repoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return self.request(input)
            .observeOn(MainScheduler.instance)
            .shareReplay(1)
    }
    
    func eventList(input: EventListInput) -> Observable<EventListOutput> {
        return self.requestArray(input)
            .observeOn(MainScheduler.instance)
            .map { events -> EventListOutput in
                return EventListOutput(events: events)
            }
            .shareReplay(1)
    }
}
