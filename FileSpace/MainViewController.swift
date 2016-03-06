//
//  ViewController.swift
//  FileSpace
//
//  Created by Jonathan on 06/03/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation


import UIKit

class MainViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    var mLabel: UILabel!
    var mPrimaryColor: UIColor!
    
    var sCount: Int = 0
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("toto");
        
        initColor();
        addButton();
        addLabel();
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func initColor() {
        mPrimaryColor = UIColor(netHex: 0x009688);
    }
    
    func addButton() {
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(20, 100, 160, 46)
        button.backgroundColor = mPrimaryColor;
        button.setTitle("My first swift button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        button.setTitleColor(UIColor.grayColor(), forState: .Selected);
        
        self.view.addSubview(button)
    }
    
    func buttonAction(sender:UIButton!) {
        increaseCount()
    }
    
    func addLabel() {
        mLabel = UILabel();
        mLabel.frame = CGRectMake(20, 200, 160, 46)
        mLabel.text = "toto " + String(sCount);
        mLabel.textColor = mPrimaryColor;
        self.view.addSubview(mLabel)
    }
    
    // must be internal or public.
    func update() {
        increaseCount()
    }
    
    func increaseCount() {
        sCount++;
        mLabel.text = "toto "+String(sCount);
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
