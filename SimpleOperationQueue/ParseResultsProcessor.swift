//
//  ParseResults.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/23/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import Foundation

class ParseResultsProcessor
{
    typealias ResultHandler = (String) -> Void

    private let processingQueue: OperationQueue =
    {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    func process(completion: @escaping ResultHandler)
    {
        let data = Data()
        let error = NSError()
        
        let parseOp = ParseResultsOperation(webQueryType: 0, data: data, error: error, completion: completion)
        
        processingQueue.addOperation(parseOp)
    }
}
