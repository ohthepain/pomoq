//
//  Preferences.swift
//  TaskTimer
//
//  Created by Paul Wilkinson on 4/22/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Foundation

struct Preferences
{
	var selectedTime : TimeInterval {
		get {
			let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
			if savedTime > 0 {
				return savedTime
			}
			return 25 * 60
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "selectedTime")
		}
	}
}
