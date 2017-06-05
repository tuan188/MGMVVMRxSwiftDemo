//
//  APIService.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/4/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxAlamofire
import Alamofire
import RxSwift
import ObjectMapper

struct URL {
    static let repoList = "https://api.github.com/search/repositories?q=language:swift&per_page=5"
//    static let repoList = "https://api.github.com/search/repo"
    static let eventList = "https://api.github.com/repos/%@/events?per_page=5"
}

enum APIError: Error {
    case invalidData(Any)
}

class APIService {
    
    private func request<T: Mappable>(_ input: APIInput) -> Observable<T> {
        let manager = SessionManager.default
        return manager.rx
            .json(input.requestType, input.urlString)
            .observeOn(MainScheduler.instance)
            .map { data -> T in
                if let json = data as? [String:Any],
                    let repo = T(JSON: json) {
                    return repo
                } else {
                    throw APIError.invalidData(data)
                }
            }
    }

    func repoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return self.request(input)
    }
}
