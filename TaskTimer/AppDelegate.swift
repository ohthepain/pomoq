//
//  AppDelegate.swift
//  TaskTimer
//
//  Created by Paul Wilkinson on 4/22/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var startTimerMenuItem: NSMenuItem!
	@IBOutlet weak var stopTimerMenuItem: NSMenuItem!
	@IBOutlet weak var resetTimerMenuItem: NSMenuItem!

	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		enableMenus(start: true, stop: false, reset: false)
		if let button = statusItem.button {
			button.image = NSImage(named:NSImage.Name("TomatoImage"))
			//button.action = #selector(printQuote(_:))
		}
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func enableMenus(start: Bool, stop: Bool, reset: Bool) {
		startTimerMenuItem.isEnabled = start
		stopTimerMenuItem.isEnabled = stop
		resetTimerMenuItem.isEnabled = reset
	}
}

