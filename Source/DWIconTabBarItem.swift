//
//  ITBTabBarItem.swift
//  Tab Bar
//
//  Created by Daniel Wischnewski on 24.08.14.
//  Copyright (c) 2014 Daniel Wischnewski. All rights reserved.
//

import Cocoa
import Foundation

/// Item, to be placed within tab bar
public class DWIconTabBarItem: NSButtonCell {
    
    ///  actual button implemented for each tab to be shown
    internal var tabBarItemButton: NSButton!

    /// icon displayed by the tab bar button
    override public var image: NSImage! {
        get {
            return self.tabBarItemButton.image
        }
        set {
            self.tabBarItemButton.image = newValue
        }
    }
    
    override public var alternateImage: NSImage! {
        get {
            return self.tabBarItemButton.alternateImage
        }
        set {
            self.tabBarItemButton.alternateImage = newValue
        }
    }

    /// tag of the tab bar button
    override public var tag: Int {
        get {
            return self.tabBarItemButton.tag
        }
        set {
            self.tabBarItemButton.tag = newValue
        }
    }
    
    /// tool tip shown when user hovers over the tab bar button
    public var toolTip: String? {
        get {
            return self.tabBarItemButton.toolTip
        }
        set {
            self.tabBarItemButton.toolTip = newValue
        }
    }
    
    /// shortcut to access the tab bar button
    override public var keyEquivalent: String! {
        get {
            return self.tabBarItemButton.keyEquivalent
        }
        set {
            self.tabBarItemButton.keyEquivalent = newValue
        }
    }
    
    /// modifier to the short cut to access the tab bar button
    override public var keyEquivalentModifierMask: Int {
        get {
            return self.tabBarItemButton.keyEquivalentModifierMask
        }
        set {
            self.tabBarItemButton.keyEquivalentModifierMask = newValue
        }
    }
    
    /// state of the tab bar button
    override public var state: Int {
        get {
            return self.tabBarItemButton.state
        }
        set {
            self.tabBarItemButton.state = newValue
        }
    }

    @objc(initImageCell:)
    override init(imageCell: NSImage) {
        self.tabBarItemButton = NSButton(frame: NSZeroRect)
        self.tabBarItemButton.setCell(DWIconTabBarButtonCell())
        self.tabBarItemButton.image = imageCell
        self.tabBarItemButton.enabled = true
        self.tabBarItemButton.sendActionOn(Int(NSEventMask.LeftMouseDownMask.toRaw()))

        super.init(imageCell: imageCell)
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc(initTextCell:)
    override init(textCell aString: String!) {
        super.init(textCell:aString)
    }
}
