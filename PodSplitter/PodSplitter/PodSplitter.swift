//
//  PodSplitter.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/7/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import Alamofire

public class PodSplitter: NSObject {
   
    public func downloadPodcast( String, callback : ( Array<NSObject>, NSError? ) -> Void ) {
        
    }
    
    func downloadUrl( podcastUrl : String, callback : ( String?, NSError? ) -> Void ) {
        Alamofire.request(.GET, podcastUrl)
                 .responseString { (request, response, xml, error) -> Void in
                    callback( xml, error );
        };
    }
    
    func parseXml( xml : NSString?, error: NSError?, callback: ( Array<NSObject>, NSError? ) -> Void ) {
        
    }
    
}
