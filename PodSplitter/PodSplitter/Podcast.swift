//
//  Podcast.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit

public class Podcast : NSObject {
    
    public var title : String
    public var link : String
    public var podcastDescription : String
    public var episodes : [Episode];
    
    public init(xml: String) {
        var podcast = SWXMLHash.parse(xml);
        
        var channel = podcast["rss"]["channel"]
        
        title = channel["title"].element?.text ?? ""
        link = channel["link"].element?.text ?? ""
        podcastDescription = channel["description"].element?.text ?? ""
        
        episodes = channel["item"].all.map { item in Episode( item: item ) }
        
        super.init()
    }
}
