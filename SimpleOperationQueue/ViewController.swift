//
//  ViewController.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/23/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var parseRequests: [UUID : ParseResultsRequest] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var resultField: UILabel!
    
    @IBAction func runAsyncTask(_ sender: UIButton)
    {
        for i in 0...100
        {
            let parseResultsProcessor = ParseResultsProcessor()
            
            let parseRequestId = UUID()
            let parseRequest = parseResultsProcessor.process()
            {
                (result) in
                var myMessage: String = ""
                
                switch result
                {
                case let .success(myString):
                    myMessage = myString
                case let .failure(error):
                    print("Error: failed to process: \(error)")
                    myMessage = error.localizedDescription
                case .cancelled:
                    print("Cancelled")
                }
                OperationQueue.main.addOperation {
                    self.resultField.text = myMessage + ":" + String(i)
                    // Stop tracking once it is complete
                    self.parseRequests[parseRequestId] = nil
                }
            }
            // start tracking this request once it is queued
            self.parseRequests[parseRequestId] = parseRequest
        }
    }
    
    @IBAction func cancelAllTasks(_ sender: UIButton)
    {
        var i = 0
        for parseRequest in parseRequests.values {
            parseRequest.cancel()
            i += 1
        }
        self.parseRequests.removeAll()
        print("Cancelled:\(i) requests")
    }

}

