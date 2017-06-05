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

enum APIError: Error {
    case invalidData(Any)
}

class APIService {
    
    private func _request(_ input: APIInput) -> Observable<Any> {
        let manager = SessionManager.default
        return manager.rx
            .request(input.requestType, input.urlString, parameters: input.parameters, encoding: input.encoding, headers: input.headers)
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .rx.json()
        }
    }
    
    func request<T: Mappable>(_ input: APIInput) -> Observable<T> {
        return _request(input)
            .map { data -> T in
                if let json = data as? [String:Any],
                    let item = T(JSON: json) {
                    return item
                } else {
                    throw APIError.invalidData(data)
                }
            }
    }
    
    func requestArray<T: Mappable>(_ input: APIInput) -> Observable<[T]> {
        return _request(input)
            .map { data -> [T] in
                if let jsonArray = data as? [[String:Any]] {
                    return Mapper<T>().mapArray(JSONArray: jsonArray)
                } else {
                    throw APIError.invalidData(data)
                }
        }
    }
}
