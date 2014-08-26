//
//  AppDelegate.swift
//  Tab Bar
//
//  Created by Daniel Wischnewski on 24.08.14.
//  Copyright (c) 2014 Daniel Wischnewski. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!
    @IBOutlet var tabBar: DWIconTabBar!
    @IBOutlet var tabView: NSTabView!

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        self.tabBar.addTabBarItem(iconImageName: "tabBarItem1_default", alternateIconImageName: "tabBarItem1_selected", toolTip: "Tab #1", keyEquivalent: "1")
        self.tabBar.addTabBarItem(iconImageName: "tabBarItem2_default", alternateIconImageName: "tabBarItem2_selected", toolTip: "Tab #2", keyEquivalent: "2")
        self.tabBar.addTabBarItem(iconImageName: "tabBarItem3_default", alternateIconImageName: "tabBarItem3_selected", toolTip: "Tab #3", keyEquivalent: "3")
        self.tabBar.relatedTabView = self.tabView
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
}

