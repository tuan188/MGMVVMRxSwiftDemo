//
//  TableView+.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/9/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    
    extension UITableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        }
    }
    
#elseif os(OSX)
    import Cocoa
    
    extension NSTableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return make(withIdentifier: String(describing: T.self), owner: self) as! T
        }
    }
    
#endif
