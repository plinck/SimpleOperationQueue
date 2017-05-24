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
    
    init(webQueryType: Int, data: Data?, error: NSError?, completion: @escaping ParseResultsProcessor.ResultHandler)
    {
        self.webQueryType = webQueryType
        self.data = data
        self.error = error
        self.completion = completion
        super.init()
    }
    
    override func main()
    {
        var result: ParseResultsProcessor.Result
        
        result = perform(webQueryType: self.webQueryType, data: self.data, error: self.error)
        print("Main Results:\(result)")
        completion(result)
    }
    
    func perform(webQueryType: Int, data: Data?, error: Error?) -> ParseResultsProcessor.Result
    {
        // Dont run if cancelled
        guard !isCancelled else {
            return(.failure(NSError(domain: "Cancelled", code: 401, userInfo: [:])))
        }

        let result = myHTMLDocument.parseHTML(htmlString: "<HI>Hello</HI>")
        print("results:\(result)")
        return(result)
    }
    
    override func cancel()
    {
        super.cancel()
    }

}
