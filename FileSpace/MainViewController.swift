//
//  ViewController.swift
//  FileSpace
//
//  Created by Jonathan on 06/03/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation

import UIKit


class MainViewController: UIViewController, TimerManagerListener, OutputManagerListener {
    // MARK: Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var mTimeLabel: UILabel!
    var mOutputTimeLabel: UILabel!
    var mPrimaryColor: UIColor!
    var mResetColor: UIColor!
    var mOutputColor: UIColor!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initColor();
        
        addLabel();
        addButtons();
        addOutputLabel();
    }
    
    override func viewWillAppear(animated: Bool) {
        TimerManager.sInstance.addTimerManagerListener(self);
        OutputManager.sInstance.addOutputManagerListener(self);
    }
    
    override func viewWillDisappear(animated: Bool) {
        TimerManager.sInstance.removeAllTimerManagerListeners();
        OutputManager.sInstance.removeOutputManagerListener();
    }
    
    func initColor() {
        mPrimaryColor = UIColor(netHex: 0x009688);
        mResetColor = UIColor(netHex: 0xDD2C00);
        mOutputColor = UIColor(netHex: 0x000000);
    }
    
    func addLabel() {
        mTimeLabel = UILabel();
        mTimeLabel.frame = CGRectMake(0, 70, self.view.frame.size.width, 100)
        mTimeLabel.textAlignment = .Center;
        mTimeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 68.0)
        mTimeLabel.textColor = mPrimaryColor;
        syncTimeLabel()
        self.view.addSubview(mTimeLabel)
    }
    
    func addButtons() {
        
        let xPosition: CGFloat = (self.view.frame.size.width - 200) / 2;
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(xPosition, 200, 200, 46)
        button.backgroundColor = mPrimaryColor;
        button.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20.0)
        button.setTitle("Start / Stop", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(MainViewController.startStop(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        button.setTitleColor(UIColor.grayColor(), forState: .Selected);
        self.view.addSubview(button)
        
        let buttonReset   = UIButton(type: UIButtonType.System) as UIButton
        buttonReset.frame = CGRectMake(xPosition, 260, 200, 46)
        buttonReset.backgroundColor = mResetColor;
        buttonReset.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20.0);
        buttonReset.setTitle("Reset", forState: UIControlState.Normal);
        buttonReset.addTarget(self, action: #selector(MainViewController.reset(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        buttonReset.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        buttonReset.setTitleColor(UIColor.grayColor(), forState: .Selected);
        self.view.addSubview(buttonReset);
    }
    
    func addOutputLabel() {
        mOutputTimeLabel = UILabel();
        mOutputTimeLabel.frame = CGRectMake(0, 320, self.view.frame.size.width, 100)
        mOutputTimeLabel.textAlignment = .Center;
        mOutputTimeLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        mOutputTimeLabel.textColor = mOutputColor;
        self.view.addSubview(mOutputTimeLabel);
        mOutputTimeLabel.text = OutputManager.sInstance.mOutput;
    }
    
    func startStop(sender:UIButton!) {
        TimerManager.sInstance.startStop();
    }
    
    func reset(sender:UIButton!) {
        TimerManager.sInstance.reset();
        OutputManager.sInstance.addOutput(".");
    }

    /**
     * Override
     */
    func onTimerUpdate(durationFromStart: TimerManagerDuration) {
        syncTimeLabel();
    }
    
    /**
     * Override
     */
    func onOutputChanged(output: String) {
        mOutputTimeLabel.text = output;
    }
    
    func syncTimeLabel() {
        mTimeLabel.text = TimerManager.sInstance.getStringCurrentTime();
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
