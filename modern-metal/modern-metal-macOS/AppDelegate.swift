//
//  AppDelegate.swift
//  modern-metal-macOS
//
//  Created by Rudolf Farkas on 09.08.19.
//  Copyright © 2019 Metal By Example. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        printClassAndFunc(info: "macOS")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

