# DWIconTabBar

DWIconTabBar is a XCode 4.x and 6.x like segmented control. It emulates the behavior of the segmented control used inside XCode's Inspector Window.

The DWIconTabBar is written from ground up in the Apple Swift language. The design and the idea are based on the DMTabBar by Daniele Margutti.

The original DMTabBar may be downloaded at <https://github.com/malcommac/DMTabBar> Daniele's original website is not available anymore, so I have dropped that link.

This document, too, is close to the original document created by Daniele Margutti. Sorry for "shamelessly stealing" his works. ;-)

## How to get started

The Icon Tab Bar is very simple to use:

* make your DWIconTabBar class via code (it's an NSView subclass) or via Interface Builder
* creating the tab bar items
	* create an NSArray of DWIconTabBarItem elements and assign it to DMTabBar tabBarItems property. Each item is a button and can have several attributes (you can simply set the NSImage's icon property)
	* use the DWIconTabBar method addTabBarItem:iconImageName:alternateIconImageName:toolTip:keyEquivalent:keyEquivalentModifierMask:tag: to create and add new elements (note, that the Icon Tab Bar **may** redraw with every call of this method)
* use the relatedTabView property to assign the tab view controlled by the DWIconTabBar, this will automatically switch the tabs according to the tab bar item pressed
* alternatively, you may handle selection changes using the selectionHandler property

## Change log

### August 26, 2014

* version 1.0

## License (MIT)

Copyright (c) 2014 Daniel Wischnewski, based on works Copyright (c) 2012 Daniele Margutti.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
