//
//  ITBTabBar.swift
//  Tab Bar
//
//  Created by Daniel Wischnewski on 24.08.14.
//  Copyright (c) 2014 Daniel Wischnewski. All rights reserved.
//

import Cocoa

/// Type of the Tab Bar Selection that currently happens
public enum ITBTabBarSelectionType{
    /// Will be sent before the tab is changing
    case WillSelect
    /// Will be sent after the tab has been changed
    case DidSelect
}

/// Call back function signature used for the event of the user changing the selected page
/// You can use the call back function to adapt other elements of the UI according to the user selection
public typealias ITBTabBarEventHandler = (selectionType: ITBTabBarSelectionType, targetTabBarItem: DWIconTabBarItem, targetTabBarItemIndex: Int) -> ()

/// inherit your NSView from this class to implement an XCode like page navigator in your projects
public class DWIconTabBar: NSView {
    
    // MARK: Properties
    
    /// border color of the tab bar
    public var lowerBorderColor: NSColor! = NSColor(deviceWhite: 1 / 255 * 179, alpha: 1.0)
    
    /// Will be called whenever the user selects another page from the tab bar
    public var selectionHandler: ITBTabBarEventHandler? = nil

    /// default width of each tab bar item
    public var tabBarItemWidth: CGFloat = 32.0
    
    /// connect to your tab view to enable auto page switching
    public weak var relatedTabView: NSTabView? = nil {
        didSet {
            self.matchTabViewSelection()
        }
    }
    
    /// start color of the tab bar gradient
    public var backgroundGradientColorStart: NSColor! = NSColor(red: 1 / 255 * 231, green: 1 / 255 * 235, blue: 1 / 255 * 239, alpha: 1.0) {
        didSet {
            self.needsDisplay = true
        }
    }
    
    /// end color of the tab bar gradient
    public var backgroundGradientColorEnd: NSColor! = nil {
        didSet {
            self.needsDisplay = true
        }
    }
    
    /// array of the tab bar items
    public var tabBarItems: [DWIconTabBarItem]! = nil {
        willSet {
            self.removeAllTabBarItems()
        }
        didSet {
            if self.tabBarItems != nil {
                for item in self.tabBarItems {
                    if let tabBarItemButton = item.tabBarItemButton {
                        tabBarItemButton.frame = NSMakeRect(0.0, 0.0, self.tabBarItemWidth, NSHeight(self.bounds))
                        tabBarItemButton.state = self.selectedTabBarItem != nil && item == self.selectedTabBarItem ? NSOnState : NSOffState
                        tabBarItemButton.action = "selectTabBarItem:"
                        tabBarItemButton.target = self
                        
                        self.addSubview(tabBarItemButton)
                    }
                }
                
                self.layoutSubviews()
                
                if self.selectedTabBarItem == nil || !contains(self.tabBarItems, self.selectedTabBarItem)
                {
                    self.selectedTabBarItem = self.tabBarItems.count > 0 ? self.tabBarItems[0] : nil;
                }
            } else {
                self.selectedTabBarItem = nil
            }
        }
    }
    
    /// tab bar item currently selected
    public var selectedTabBarItem: DWIconTabBarItem! = nil {
        didSet {
            if (self.selectedTabBarItem == nil) || (oldValue != nil && oldValue == self.selectedTabBarItem) {
                return
            }
            if !contains(self.tabBarItems, self.selectedTabBarItem) {
                self.selectedTabBarItem = nil
                return
            }
            for item in self.tabBarItems {
                item.state = item == self.selectedTabBarItem ? NSOnState : NSOffState
            }
            self.matchTabViewSelection()
        }
    }
    
    /// index of the tab bar item currently selected
    var selectedTabBarItemIndex: Int {
        get {
            if (self.tabBarItems == nil) {
                return -1
            }
            
            return find(self.tabBarItems, self.selectedTabBarItem) ?? -1
        }
        set {
            if newValue >= 0 && newValue < self.tabBarItems.count {
                self.selectedTabBarItem = self.tabBarItems[newValue]
            }
        }
    }
    
    // MARK: Helper Functions
    
    /// Adds a new item to the tab bar
    ///
    /// :param: iconImageName
    ///     Name of the resource image used to represent the tab bar item
    /// :param: toolTip
    ///     Tool tip shown to user when mouse hovers over tab bar item
    /// :param: keyEquivalent
    ///     Short cut for accessing the tab bar item
    /// :param: keyEquivalentModifierMask
    ///     Modifier to keyEquivalent for accessing the tab bar item
    /// :param: tag
    ///     Tag value of the tab bar item
    /// :returns:
    ///     newly created tab bar item (has been added to tabBarItems array)
    public func addTabBarItem(iconImageName iconName: String, alternateIconImageName altIconName: String? = nil, toolTip: String? = nil, keyEquivalent: String? = nil, keyEquivalentModifierMask: NSEventModifierFlags = NSEventModifierFlags.CommandKeyMask, tag: Int = 0) -> DWIconTabBarItem {

        // load item image
        let iconImage = NSImage(named: iconName)
        iconImage.setTemplate(true)

        // create item
        let newItem = DWIconTabBarItem(imageCell: iconImage)
        
        // load alternative image
        if let altIcon = altIconName? {
            let altIconImage = NSImage(named: altIcon)
            altIconImage.setTemplate(true)
            newItem.alternateImage = altIconImage
        }
        
        // set properties remaining
        newItem.toolTip = toolTip
        newItem.keyEquivalent = keyEquivalent
        newItem.keyEquivalentModifierMask = Int(keyEquivalentModifierMask.toRaw())
        newItem.tag = tag

        // update tabBarItems
        if self.tabBarItems == nil {
            self.tabBarItems = []
        }
        self.tabBarItems.append(newItem)
        
        return newItem
    }
    
    // MARK: De-/Initializers
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Drawing
    
    override public func drawRect(dirtyRect: NSRect) {
        // Draw bar gradient, if its color is set
        if self.backgroundGradientColorStart != nil && self.backgroundGradientColorEnd != nil
        {
            NSGradient(startingColor: self.backgroundGradientColorStart, endingColor: self.backgroundGradientColorEnd).drawInRect(dirtyRect, angle: 90.0)
        } else if self.backgroundGradientColorStart != nil {
            self.backgroundGradientColorStart.set()
            NSRectFill(dirtyRect)
        }
        
        // Draw drak gray bottom border, if its color is set
        if self.lowerBorderColor != nil
        {
            self.lowerBorderColor.setStroke()
            let bezier = NSBezierPath()
            bezier.lineWidth = 1.0
            bezier.moveToPoint(NSMakePoint(NSMinX(self.bounds), NSMaxY(self.bounds)))
            bezier.lineToPoint(NSMakePoint(NSMaxX(self.bounds), NSMaxY(self.bounds)))
            bezier.stroke()
        }
    }
    
    /// use flipped coordinate system
    override public var flipped: Bool {
        return true
    }

    deinit {
        self.removeAllTabBarItems()
    }
    
    /// removes all items from its view
    private func removeAllTabBarItems() {
        if self.tabBarItems != nil {
            for tabBarItem in self.tabBarItems {
                tabBarItem.tabBarItemButton.removeFromSuperview()
            }
        }
    }
    
    // MARK: Event Handler
    
    /// called when the user clicks on of the buttons
    internal func selectTabBarItem(sender: NSObject) {
        var tabBarItem: DWIconTabBarItem! = nil

        // find send in array
        for item in self.tabBarItems {
            if (sender == item.tabBarItemButton)
            {
                tabBarItem = item
                break
            }
        }

        // sender found,
        if tabBarItem != nil {
            var index = find(self.tabBarItems, tabBarItem)!
            
            if let handler = self.selectionHandler {
                handler(selectionType: ITBTabBarSelectionType.WillSelect, targetTabBarItem: tabBarItem, targetTabBarItemIndex: index)
                self.selectedTabBarItem = tabBarItem
                handler(selectionType: ITBTabBarSelectionType.DidSelect, targetTabBarItem: tabBarItem, targetTabBarItemIndex: index)
            } else {
                self.selectedTabBarItem = tabBarItem
            }
        }
    }
    
    /// called to update the tab view for the selected tab bar item
    private func matchTabViewSelection() {
        var index = self.selectedTabBarItemIndex
        if index < 0 {
            return
        }
        if let tabView = self.relatedTabView {
            tabView.selectTabViewItemAtIndex(index)
        }
    }
    
    // MARK: Layout Subviews
    
    /// called when the view gets resized
    override public func resizeSubviewsWithOldSize(oldSize: NSSize) {
        super.resizeSubviewsWithOldSize(oldSize)
        self.layoutSubviews()
    }
    
    /// re-aligns the items within the tab bar 
    private func layoutSubviews() {
        if self.tabBarItems != nil {
            let totalWidth = Float(self.tabBarItems.count) * Float(self.tabBarItemWidth)
            var xPos = CGFloat(floorf((Float(NSWidth(self.bounds)) - totalWidth) / 2.0))
            
            for item in self.tabBarItems {
                item.tabBarItemButton.frame = NSMakeRect(xPos, NSMinY(self.bounds), self.tabBarItemWidth, NSHeight(self.bounds))
                xPos += self.tabBarItemWidth
            }
        }
    }
}
