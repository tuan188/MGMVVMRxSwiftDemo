//
//  AppDelegate.swift
//  macOS
//
//  Created by Tuan Truong on 6/8/17.
//  Copyright © 2017 Tuan Truong. All rights reserved.
//

import Cocoa
import RxSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let navigator = Navigator()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        guard let splitController = NSApp.windows.first?.contentViewController as? NSSplitViewController else {
            fatalError("Can't find content controller")
        }
        
        
        navigator.show(segue: .repoList, sender: splitController)
        navigator.show(segue: .eventList(repo: Variable(Repo())), sender: splitController)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

