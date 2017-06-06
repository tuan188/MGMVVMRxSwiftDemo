//
//  APIService.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/4/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

enum APIError: Error {
    case invalidURL(url: String)
    case invalidResponseData(data: Any)
    case error(responseCode: Int, data: Any)
}

class APIService {
    
    private func _request(_ input: APIInput) -> Observable<Any> {
        return Observable
            .just(input.urlString)
            .map { (urlString) -> URL in
                if let url = URL(string: urlString) {
                    return url
                }
                throw APIError.invalidURL(url: urlString)
            }
            .map { (url) -> URLRequest in
                return URLRequest(url: url)
            }
            .flatMap { (request) -> Observable<(HTTPURLResponse, Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { (response, data) -> Bool in
                if 200..<300 ~= response.statusCode {
                    return true
                }
                throw APIError.error(responseCode: response.statusCode, data: data)
            }
            .map { _, data -> Any in
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                    return jsonObject
                }
                throw APIError.invalidResponseData(data: data)
            }
    }
    
    func request<T: Mappable>(_ input: APIInput) -> Observable<T> {
        return _request(input)
            .map { data -> T in
                if let json = data as? [String:Any],
                    let item = T(JSON: json) {
                    return item
                } else {
                    throw APIError.invalidResponseData(data: data)
                }
            }
    }
    
    func requestArray<T: Mappable>(_ input: APIInput) -> Observable<[T]> {
        return _request(input)
            .map { data -> [T] in
                if let jsonArray = data as? [[String:Any]] {
                    return Mapper<T>().mapArray(JSONArray: jsonArray)
                } else {
                    throw APIError.invalidResponseData(data: data)
                }
        }
    }
}
