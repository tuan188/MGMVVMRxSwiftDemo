//
//  APIInput.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/5/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class APIInputBase {
    var headers = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    let urlString: String
    let requestType: HTTPMethod
    var encoding: ParameterEncoding
    let parameters: [String: Any]?
    let requireAccessToken: Bool
    
    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod, requireAccessToken: Bool = true) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.requireAccessToken = requireAccessToken
    }
}
