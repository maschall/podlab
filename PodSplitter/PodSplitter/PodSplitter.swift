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
   
    public func downloadPodcast( podcastUrl : String, callback : ( Podcast?, NSError? ) -> Void ) {
        self.downloadUrl(podcastUrl) { ( xml: String?, error: NSError? ) -> Void in
            callback( xml != nil ? Podcast(xml: xml!) : nil, error )
        }
    }
    
    func downloadUrl( podcastUrl : String, callback : ( String?, NSError? ) -> Void ) {
        Alamofire.request(.GET, podcastUrl)
                 .responseString { (request, response, xml, error) -> Void in
                    callback( xml, error );
        }
    }
    
}
