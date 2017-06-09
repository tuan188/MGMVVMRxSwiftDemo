//
//  APIInput.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum ParameterEncoding {
    case url
    case json
}

class APIInput {
    let headers = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    let urlString: String
    let requestType: HTTPMethod
    var encoding: ParameterEncoding
    let parameters: [String: Any]?
    
    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? .url : .json
    }
}
