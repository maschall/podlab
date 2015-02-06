//
//  DownloadManager.swift
//  PodLabCommon
//
//  Created by Mark Schall on 2/3/15.
//
//

import Foundation
import Alamofire

public class DownloadManager {
    public class var instance : DownloadManager {
        struct Static {
            static let instance : DownloadManager = DownloadManager()
        }
        return Static.instance
    }
    
    var queue = [Episode: Request]()
    
    public func download( episode : Episode ) {
        if queue.indexForKey(episode) == nil {
            queue[episode] = Alamofire.download(.GET, episode.enclosure.url) { (temporaryUrl, response) -> (NSURL) in
                return episode.downloadFilePath;
            }
        }
    }
}