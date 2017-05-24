//
//  HTMLDocument.swift
//  SimpleOperationQueue
//
//  Created by Paul Linck on 5/23/17.
//  Copyright © 2017 Paul Linck. All rights reserved.
//

import Foundation

class HTMLDocument
{
    func parseHTML(htmlString: String) -> ParseResultsProcessor.Result
    {
        var result: ParseResultsProcessor.Result
        
        if true {
            result = .success("Successful Parse")
            // delay to take some time in the task
            sleep(3)
        }
        else {
            let err = NSError(domain: "SimpleOperationQueue", code: 401, userInfo: [:])
            result = .failure(err)
        }
        return(result)

    }
}
