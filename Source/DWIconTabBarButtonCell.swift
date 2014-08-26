//
//  ITBTabBarButtonCell.swift
//  Tab Bar
//
//  Created by Daniel Wischnewski on 24.08.14.
//  Copyright (c) 2014 Daniel Wischnewski. All rights reserved.
//

import Cocoa

/// Helper class to draw the item on the tab bar correctly
internal class DWIconTabBarButtonCell: NSButtonCell {
    
    @objc(init)
    override init() {
        super.init()
        self.bezelStyle = NSBezelStyle.TexturedSquareBezelStyle
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.bezelStyle = NSBezelStyle.TexturedSquareBezelStyle
    }
    
    @objc(initTextCell:)
    override init(textCell aString: String!) {
        super.init(textCell: aString)
        self.bezelStyle = NSBezelStyle.TexturedSquareBezelStyle
    }
    
    func nextState() -> Int {
        return self.state
    }
    
    override func drawImage(image: NSImage!, withFrame frame: NSRect, inView controlView: NSView!) {
        var image = self.state == NSOffState ? self.image : self.alternateImage ?? self.image

        var imageRect = NSZeroRect;
        imageRect.origin.y = CGFloat(round(controlView.frame.size.height * 0.5 - image.size.height * 0.5))
        imageRect.origin.x = CGFloat(round(controlView.frame.size.width * 0.5 - image.size.width * 0.5))
        imageRect.size = image.size;

        image.drawInRect(imageRect, fromRect: NSZeroRect, operation: NSCompositingOperation.CompositeDifference, fraction: 1.0, respectFlipped: true, hints: nil)
    }
    
    override func drawBezelWithFrame(frame: NSRect, inView controlView: NSView!) {
        // set state to avoid flickr when using keyboard short cuts
        self.highlighted = self.state == NSOnState
        
        if self.state == NSOnState && self.alternateImage == nil {
            NSGraphicsContext.currentContext().saveGraphicsState()

            // define background gradient of item selected
            let locations: [CGFloat] = [0.0, 0.5, 1.0]
            let gradientColor1 = NSColor(calibratedWhite: 0.7, alpha: 0.0)
            let gradientColor2 = NSColor(calibratedWhite: 0.7, alpha: 1.0)
            let gradient = NSGradient(colors: [gradientColor1, gradientColor2, gradientColor1], atLocations: locations, colorSpace: NSColorSpace.genericGrayColorSpace())
            gradient.drawInRect(frame, angle: -90.0)
            
            // create shadows left and right around item selected
            let shadow = NSShadow()
            shadow.shadowOffset = NSMakeSize(1.0, 0.0)
            shadow.shadowBlurRadius = 2.0
            shadow.shadowColor = NSColor.darkGrayColor()
            shadow.set()
            
            NSColor.blackColor().set()
            let radius: CGFloat = 50.0
            var center = NSMakePoint(NSMinX(frame) - radius, NSMidY(frame))
            var path = NSBezierPath()
            path.moveToPoint(center)
            path.appendBezierPathWithArcWithCenter(center, radius: radius, startAngle: -90.0, endAngle: 90.0)
            path.closePath()
            path.fill()
            
            shadow.shadowOffset = NSMakeSize(-1.0, 0.0)
            shadow.set()
            
            center = NSMakePoint(NSMaxX(frame) + radius, NSMidY(frame));
            path = NSBezierPath()
            path.moveToPoint(center)
            path.appendBezierPathWithArcWithCenter(center, radius: radius, startAngle: 90.0, endAngle: 270.0)
            path.closePath()
            path.fill()
            
            NSGraphicsContext.currentContext().restoreGraphicsState()
        }
    }
}


