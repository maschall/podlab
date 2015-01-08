//
//  Episode.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit

public class Episode : NSObject {
    
    public var title : String
    public var link : String
    public var enclosure: Enclosure
    
    init(item: XMLIndexer) {
        title = item["title"].element?.text ?? ""
        link = item["link"].element?.text ?? ""
        enclosure = Enclosure(enclosure: item["enclosure"])
        
        super.init()
    }
    
}