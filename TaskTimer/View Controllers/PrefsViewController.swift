//
//  PrefsViewController.swift
//  TaskTimer
//
//  Created by Paul Wilkinson on 4/22/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {
	
	@IBOutlet weak var presetsPopup: NSPopUpButton!
	@IBOutlet weak var customSlider: NSSlider!
	@IBOutlet weak var customTextField: NSTextField!
	
	var prefs = Preferences()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		showExistingPrefs()
    }

	func showExistingPrefs() {
		customSlider.integerValue = Int(prefs.selectedTime)
		customTextField.stringValue = "\(customSlider.integerValue) minutes"
	}
	
	@IBAction func popupValueChanged(_ sender: Any) {
	}
	@IBAction func sliderValueChanged(_ sender: Any) {
		prefs.selectedTime = Double(customSlider.integerValue)
		customTextField.stringValue = "\(customSlider.integerValue) minutes"
	}
	@IBAction func cancelButtonClicked(_ sender: Any) {
	}
	@IBAction func okButtonClicked(_ sender: Any) {
	}
}
