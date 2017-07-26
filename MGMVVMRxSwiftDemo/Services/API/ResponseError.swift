//
//  ResponseError.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 7/26/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import UIKit

enum ResponseError: Error {
    case noStatusCode
    case invalidData(data: Any)
    
    case unknown(statusCode: Int)
    case notModified // 304
    case invalidRequest // 400
    case unauthorized // 401
    case accessDenied // 403
    case notFound  // 404
    case methodNotAllowed  // 405
    case validate   // 422
    case serverError // 500
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
}
