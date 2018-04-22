//
//  ViewController.swift
//  TaskTimer
//
//  Created by Paul Wilkinson on 4/22/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
	@IBOutlet weak var timeLeftField: NSTextField!
	@IBOutlet weak var eggImageView: NSImageView!
	@IBOutlet weak var startButton: NSButton!
	@IBOutlet weak var stopButton: NSButton!
	@IBOutlet weak var resetButton: NSButton!
	
	var taskTimer = TaskTimer()

	override func viewDidLoad() {
		super.viewDidLoad()

		taskTimer.delegate = self
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	private func configureMenusAndButtons() {
		if taskTimer.isStopped {
			startButton.isEnabled = true
			stopButton.isEnabled = false
			resetButton.isEnabled = false
		} else if taskTimer.isPaused {
			startButton.isEnabled = true
			stopButton.isEnabled = false
			resetButton.isEnabled = true
		} else {
			startButton.isEnabled = false
			stopButton.isEnabled = true
			resetButton.isEnabled = true
		}
		
		if let appDel = NSApplication.shared.delegate as? AppDelegate {
		  appDel.enableMenus(start: startButton.isEnabled, stop: stopButton.isEnabled, reset: resetButton.isEnabled)
		}
	}
	
	@IBAction func startButtonClicked(_ sender: Any) {
		if taskTimer.isPaused {
			taskTimer.resumeTimer()
		} else {
			taskTimer.duration = 360
			taskTimer.startTimer()
		}
		configureMenusAndButtons()
	}
	
	@IBAction func stopButtonClicked(_ sender: Any) {
		taskTimer.stopTimer()
		configureMenusAndButtons()
	}
	
	@IBAction func resetButtonClicked(_ sender: Any) {
		taskTimer.resetTimer()
		configureMenusAndButtons()
	}

	// MARK: - IBActions - menus
	
	@IBAction func startTimerMenuItemSelected(_ sender: Any) {
		startButtonClicked(sender)
	}
	
	@IBAction func stopTimerMenuItemSelected(_ sender: Any) {
		stopButtonClicked(sender)
	}
	
	@IBAction func resetTimerMenuItemSelected(_ sender: Any) {
		resetButtonClicked(sender)
	}
}

extension ViewController : TaskTimerProtocol
{
	func updateDisplay(for timeRemaining: TimeInterval) {
		timeLeftField.stringValue = textToDisplay(for: timeRemaining)
		eggImageView.image = imageToDisplay(for: timeRemaining)
	}
	
	private func textToDisplay(for timeRemaining: TimeInterval) -> String {
		if timeRemaining == 0 {
			return "Done!"
		}
		
		let minutesRemaining = floor(timeRemaining / 60)
		let secondsRemaining = timeRemaining - (minutesRemaining * 60)
		let secondsDisplay = String(format:"%02d", Int(secondsRemaining))
		let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
		return timeRemainingDisplay
	}
	
	private func imageToDisplay(for timeRemaining: TimeInterval) -> NSImage {
		let percentageComplete = 100 - (timeRemaining / 360 * 100)
		
		if taskTimer.isStopped {
			let stoppedImageName = (timeRemaining == 0) ? "100" : "stopped"
			return NSImage(named: NSImage.Name(rawValue: stoppedImageName))!
		}
		
		let imageName : String
		switch percentageComplete {
		case 0 ..< 25:
			imageName = "0"
		case 25 ..< 50:
			imageName = "25"
		case 50 ..< 75:
			imageName = "50"
		case 75 ..< 100:
			imageName = "75"
		default:
			imageName = "100"
		}
		return NSImage(named: NSImage.Name(rawValue: imageName))!
	}
	
	func timeRemainingOnTimer(_ timer: TaskTimer, timeRemaining: TimeInterval) {
		updateDisplay(for: timeRemaining)
	}
	
	func timerHasFinished(_ timer: TaskTimer) {
		updateDisplay(for: 0)
	}
}
