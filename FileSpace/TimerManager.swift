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
    var mTimerManagerListeners = [TimerManagerListener]()
    
    private init () {
        mDuration = TimerManagerDuration();
    }
    
    internal func start() {
        mTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(TimerManager.update), userInfo: nil, repeats: true);
    }
    
    internal func stop() {
        mTimer.invalidate();
        mTimer = nil;
    }
    
    internal func addTimerManagerListener(timerManagerListener: TimerManagerListener) {
        mTimerManagerListeners.append(timerManagerListener);
    }
    
    internal func removeTimerManagerListener(timerManagerListener: TimerManagerListener) {
        //mTimerManagerListeners.remo(timerManagerListener);
    }
    
    /**
     * Must be internal or public.
     */
    @objc func update() {
        mDuration.increase();
    }
}

class TimerManagerDuration : CustomStringConvertible {
    private var mMinute: Int = 0;
    private var mSecond: Int = 0;
    private var mCentSecond: Int = 0;
    
    var description: String {
        return "mMinute : \(mMinute), mSecond : \(mSecond), mCentSecond : \(mCentSecond)"
    }
    
    internal init() {
        
    }
    
    func increase() {
        mCentSecond += 1;
        if (mCentSecond>=100) {
            mCentSecond = 0;
            mSecond += 1;
            if(mSecond >= 60) {
                mSecond = 0;
                mMinute += 1;
            }
        }
    }
}

protocol TimerManagerListener {

    mutating func onTimerUpdate(durationFromStart: TimerManagerDuration);
}