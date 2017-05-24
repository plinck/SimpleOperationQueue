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
                (resultString) in
                
                OperationQueue.main.addOperation {
                    self.resultField.text = resultString
                }
        }
        
    }
    
}

