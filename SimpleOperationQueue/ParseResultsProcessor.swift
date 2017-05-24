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
    
    enum Result {
        case success(String)
        case failure(NSError)
        case cancelled
    }
    
    enum Priority {
        case high
        case low
    }

    typealias ResultHandler = (Result) -> Void

    private let processingQueue: OperationQueue =
    {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    func process(completion: @escaping ResultHandler) -> ParseResultsRequest
    {
        let data = Data()
        let error = NSError()
        
        let parseOp = ParseResultsOperation(webQueryType: 0, data: data, error: error, completion: completion)
        let request = ParseResultsRequest(operation: parseOp, queue: processingQueue)
        processingQueue.addOperation(parseOp)
        
        return(request)
    }
}
