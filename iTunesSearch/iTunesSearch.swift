//
//  iTunesSearch.swift
//  iTunesSearch
//
//  Created by Mark Schall on 1/9/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Alamofire

public class iTunesSearch: NSObject {
    
    public class func search( term: String, callback: ( [[String: AnyObject]]?, NSError? ) -> Void ) {
        Alamofire.request(.GET, "http://itunes.apple.com/search?limit=200&media=podcast&term=\(term)")
            .responseJSON { (request, response, json, error) -> Void in
                if let error = error {
                    callback( nil, error )
                } else if let json = json as? [String: AnyObject] {
                    if let results = json["results"] as? [[String: AnyObject]] {
                        callback( results, nil )
                    }
                }
        }
        
    }
}