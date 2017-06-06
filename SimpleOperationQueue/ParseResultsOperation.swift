//
//  ParseResultsOperation.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/23/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import Foundation

class ParseResultsOperation: Operation
{
    var webQueryType: Int = 0
    var data: Data?
    var error: NSError?
    let myHTMLDocument = HTMLDocument()
    let completion: ParseResultsProcessor.ResultHandler
    
    init(webQueryType: Int, data: Data?, error: NSError?,
         priority: ParseResultsProcessor.Priority = .low,
         completion: @escaping ParseResultsProcessor.ResultHandler)
    {
        self.webQueryType = webQueryType
        self.data = data
        self.error = error
        self.completion = completion
        super.init()
    }
    
    convenience init(operation: ParseResultsOperation, priority: ParseResultsProcessor.Priority = .low)
    {
        self.init(webQueryType: operation.webQueryType, data: operation.data,
                  error: operation.error,
                  priority: priority, completion: operation.completion)
    }

    
    override func main()
    {
        var result: ParseResultsProcessor.Result
        
        result = perform(webQueryType: self.webQueryType, data: self.data, error: self.error)
        completion(result)
    }
    
    func perform(webQueryType: Int, data: Data?, error: Error?) -> ParseResultsProcessor.Result
    {
        // Dont run if cancelled
        guard !isCancelled else {
            //return(.failure(NSError(domain: "Cancelled", code: 401, userInfo: [:])))
            return(.cancelled)
        }

        let result = myHTMLDocument.parseHTML(htmlString: "<HI>Hello</HI>")
        
        guard !isCancelled else {
            //return(.failure(NSError(domain: "Cancelled", code: 401, userInfo: [:])))
            return(.cancelled)
        }

        return(result)
    }
    
    override func cancel()
    {
        super.cancel()
    }

}
