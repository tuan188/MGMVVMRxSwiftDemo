//
//  Storyboard+.swift
//  MGMVVMRxSwiftDemo
//
//  Created by Tuan Truong on 6/8/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    extension UIStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateViewController(withIdentifier: String(describing: type)) as! T
        }
    }
#elseif os(OSX)
    import Cocoa
    
    extension NSStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateController(withIdentifier: String(describing: type)) as! T
        }
    }
#endif
