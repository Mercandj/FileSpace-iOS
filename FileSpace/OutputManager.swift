//
//  OutputManager.swift
//  FileSpace
//
//  Created by Jonathan on 07/08/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation


class OutputManager {
    
    static let sInstance = OutputManager();
    
    var mOutput: String;
    var mOutputManagerListeners = [OutputManagerListener]();
    
    private init () {
        mOutput = "Output";
    }
    
    /**
     *
     */
    internal func addOutputManagerListener(outputManagerListener: OutputManagerListener) {
        mOutputManagerListeners.append(outputManagerListener);
    }
    
    internal func removeOutputManagerListener() {
        mOutputManagerListeners.removeAll();
    }
    
    internal func addOutput(stringToAdd: String) {
        mOutput += stringToAdd;
        notifyOutputChangedListeners();
    }
    
    internal func getOutput() -> String {
        return mOutput;
    }
    
    internal func setOutput(output: String) {
        mOutput = output;
        notifyOutputChangedListeners();
    }
    
    private func notifyOutputChangedListeners() {
        for outputManagerListener in mOutputManagerListeners {
            outputManagerListener.onOutputChanged(mOutput);
        }
    }
}


protocol OutputManagerListener {
    
    func onOutputChanged(output: String);
}

