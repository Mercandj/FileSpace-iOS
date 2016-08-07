//
//  TimerManager.swift
//  FileSpace
//
//  Created by Jonathan on 07/08/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation


class TimerManager {

    static let sInstance = TimerManager();
    
    var mTimer: NSTimer!
    var mDuration: TimerManagerDuration;
    var mTimerManagerListeners = [TimerManagerListener]();
    
    private init () {
        mDuration = TimerManagerDuration();
    }
    
    internal func startStop() {
        if (!isStarted()) {
            start();
        } else {
            stop();
        }
    }
    
    internal func start() {
        mTimer = NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: #selector(TimerManager.update),
            userInfo: nil,
            repeats: true);
    }
    
    internal func stop() {
        mTimer.invalidate();
        mTimer = nil;
    }
    
    internal func reset() {
        mDuration.reset();
        notifyListeners(mDuration);
    }
    
    internal func getStringCurrentTime() -> String {
        return mDuration.getStringCount();
    }
    
    internal func addTimerManagerListener(timerManagerListener: TimerManagerListener) {
        mTimerManagerListeners.append(timerManagerListener);
    }
    
    internal func removeAllTimerManagerListeners() {
        mTimerManagerListeners.removeAll();
    }
    
    internal func isStarted() -> Bool {
        return mTimer != nil;
    }
    
    /**
     * Must be internal or public.
     */
    @objc func update() {
        mDuration.increase();
        notifyListeners(mDuration);
    }
    
    private func notifyListeners(durationFromStart: TimerManagerDuration) {
        for timerManagerListener in mTimerManagerListeners {
            timerManagerListener.onTimerUpdate(durationFromStart);
        }
    }
}

class TimerManagerDuration : CustomStringConvertible {
    private var mMinute: Int = 0;
    private var mSecond: Int = 0;
    private var mCentSecond: Int = 0;
    
    var description: String {
        return "mMinute : \(mMinute), mSecond : \(mSecond), mCentSecond : \(mCentSecond)";
    }
    
    internal init() {
        
    }
    
    func increase() {
        mCentSecond += 1;
        if (mCentSecond >= 100) {
            mCentSecond = 0;
            mSecond += 1;
            if(mSecond >= 60) {
                mSecond = 0;
                mMinute += 1;
            }
        }
    }
    
    func reset() {
        mMinute = 0;
        mSecond = 0;
        mCentSecond = 0;
    }
    
    func getStringCount() -> String {
        var cent:String;
        if (mCentSecond < 10) {
            cent = ":0" + String(mCentSecond)
        } else {
            cent = ":" + String(mCentSecond)
        }
        
        if (mSecond < 10) {
            return String(mMinute) + ":0" + String(mSecond) + cent;
        } else {
            return String(mMinute) + ":" + String(mSecond) + cent;
        }
    }
}

protocol TimerManagerListener {

    func onTimerUpdate(durationFromStart: TimerManagerDuration);
}
