//
//  NetworkManager.swift
//  FileSpace
//
//  Created by Jonathan on 07/08/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

import Foundation


class NetworkManager {
    
    static let sInstance = NetworkManager();
    
    var mNetworkGetListeners = [NetworkGetListener]();
    
    private init () {
    }
    
    /**
     * Rest GET call.
     * See http://stackoverflow.com/questions/24016142/how-to-make-an-http-request-in-swift
     */
    internal func get(requestId: Int, urlString: String) {
        let url: NSURL = NSURL(string: urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "GET";
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    print("ASynchronous\(jsonResult)");
                    self.notifyNetworkGetSucceeded(requestId, resultOutput: "\(jsonResult)");
                    return;
                }
                self.notifyNetworkGetFailed(requestId, errorOutput: "Cannot parse the json.");
            } catch let error as NSError {
                print(error.localizedDescription);
                self.notifyNetworkGetFailed(requestId, errorOutput: error.localizedDescription);
            }
        };
        task.resume();
    }
    
    /**
     *
     */
    internal func addNetworkGetListener(networkGetListener: NetworkGetListener) {
        mNetworkGetListeners.append(networkGetListener);
    }
    
    internal func removeNetworkGetListener() {
        mNetworkGetListeners.removeAll();
    }
    
    private func notifyNetworkGetSucceeded(requestId: Int, resultOutput: String) {
        for networkGetListener in mNetworkGetListeners {
            networkGetListener.onGetSucceeded(requestId, result: resultOutput);
        }
    }
    
    private func notifyNetworkGetFailed(requestId: Int, errorOutput: String) {
        for networkGetListener in mNetworkGetListeners {
            networkGetListener.onGetFailed(requestId, error: errorOutput);
        }
    }
}


protocol NetworkGetListener {
    
    func onGetSucceeded(requestId: Int, result: String);
    
    func onGetFailed(requestId: Int, error: String);
}
