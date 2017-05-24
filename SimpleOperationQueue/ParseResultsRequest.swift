//
//  ParseResultsRequest.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/24/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import Foundation

class ParseResultsRequest
{
    private var operation: ParseResultsOperation
    private let queue: OperationQueue
    
    var priority: ParseResultsProcessor.Priority = .low {
        didSet(oldPriority) {
            guard priority != oldPriority else { return }
            guard !operation.isExecuting else { return }
            let newOp = ParseResultsOperation(operation: operation, priority: priority)
            operation.cancel()
            operation = newOp
            queue.addOperation(newOp)
        }
    }
    
    init(operation: ParseResultsOperation, queue: OperationQueue) {
        self.operation = operation
        self.queue = queue
    }
    
    func cancel() {
        operation.cancel()
    }
}
