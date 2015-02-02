//
//  PodSplitter.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/7/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Alamofire

public class PodSplitter {
   
    public init() {
        
    }
    
    public func downloadPodcast( podcastUrl : String, callback : ( Podcast?, NSError? ) -> Void ) {
        var podcast = Podcast( url: podcastUrl )
        self.updatePodcast(podcast, callback: { (error) -> Void in
            callback( podcast, error )
        })
    }
    
    public func updatePodcast( podcast: Podcast, callback : ( NSError? ) -> Void ) {
        self.downloadUrl(podcast.url) { ( xml, error ) -> Void in
            if let xml = xml {
                podcast.updateData(xml)
            }
            callback( error )
        }
    }
    
    func downloadUrl( podcastUrl : String, callback : ( String?, NSError? ) -> Void ) {
        Alamofire.request(.GET, podcastUrl)
                 .responseString { (request, response, xml, error) -> Void in
                    callback( xml, error );
        }
    }
    
}
