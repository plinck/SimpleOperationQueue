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
        var result: String = ""
        
        result = perform(webQueryType: self.webQueryType, data: self.data, error: self.error)
        print("Main Results:\(result)")
        completion(result)

        // now what?
    }
    
    func perform(webQueryType: Int, data: Data?, error: Error?) -> String
    {
        let result = myHTMLDocument.parseHTML(htmlString: "<HI>Hello</HI>")
        print("results:\(result)")
        return(result)
    }
}
