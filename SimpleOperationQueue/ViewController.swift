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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var resultField: UILabel!
    
    @IBAction func runAsyncTask(_ sender: UIButton)
    {
        self.runButton.isEnabled = false
        self.cancelButton.isEnabled = true
        self.resultField.text = "Stand back while I get to some parsin'"
        
        let parseResultsProcessor = ParseResultsProcessor()

        for i in 0...100
        {
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
//                OperationQueue.main.addOperation {
                DispatchQueue.main.async {
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
//        var i = 0
//        for parseRequest in parseRequests.values {
//            parseRequest.cancel()
//            i += 1
//        }
        
        for (index, request) in parseRequests.values.enumerated() {
            request.cancel()
            print("Cancelling request:\(index)")
        }

        print("Cancelled:\(parseRequests.values.count) requests")
        self.parseRequests.removeAll()
        
        initButtonState()
    }
    
    private func initButtonState() {
        self.resultField.text = "Tap 'Run' to start processing"
        self.cancelButton.isEnabled = false
        self.runButton.isEnabled = true
    }
    
}

