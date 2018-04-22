//
//  TaskTimer.swift
//  TaskTimer
//
//  Created by Paul Wilkinson on 4/22/18.
//  Copyright © 2018 Paul Wilkinson. All rights reserved.
//

import Foundation

protocol TaskTimerProtocol
{
	func timeRemainingOnTimer(_ timer: TaskTimer, timeRemaining: TimeInterval)
	func timerHasFinished(_ timer: TaskTimer)
}

class TaskTimer
{
	var timer : Timer? = nil
	var startTime : Date?
	// TimeInterval is really a double. It's seconds
	var duration : TimeInterval = 360
	var elapsedTime : TimeInterval = 0
	
	var delegate : TaskTimerProtocol?
	
	var isStopped : Bool {
		return timer == nil && elapsedTime == 0
	}
	
	var isPaused : Bool {
		return timer == nil && elapsedTime > 0
	}
	
	@objc dynamic func timerAction() {
		// if there is no start time then timer isn't running
		guard let startTime = startTime else {
			delegate?.timeRemainingOnTimer(self, timeRemaining: duration)
			return
		}
		
		elapsedTime = -startTime.timeIntervalSinceNow
		
		let secondsRemaining = (duration - elapsedTime).rounded()
		
		if secondsRemaining <= 0 {
			resetTimer()
			delegate?.timerHasFinished(self)
		} else {
			delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
		}
	}
	
	func startTimer() {
		startTime = Date()
		elapsedTime = 0
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
		timerAction()
	}
	
	func stopTimer() {
		timer?.invalidate()
		timer = nil
		timerAction()
	}
	
	func resumeTimer() {
		startTime = Date(timeIntervalSinceNow: -elapsedTime)
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
		timerAction()
	}
	
	func pauseTimer() {
		timer?.invalidate()
		timer = nil
		timerAction()
	}
	
	func resetTimer() {
		timer?.invalidate()
		timer = nil
		startTime = nil
		elapsedTime = 0
		duration = 360
		timerAction()
	}
}
