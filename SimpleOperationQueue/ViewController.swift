//
//  ViewController.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/23/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        let parseResultsProcessor = ParseResultsProcessor()
        
        parseResultsProcessor.process()
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
                self.resultField.text = myMessage
            }
        
        }
    }
}

