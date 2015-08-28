//
//  Episode.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

public class Episode : NSCoding {
    
    public var title : String
    public var link : String
    public var guid : String
    public var enclosure: Enclosure
    
    init(item: XMLIndexer) {
        title = item["title"].element?.text ?? ""
        link = item["link"].element?.text ?? ""
        guid = item["guid"].element?.text ?? ""
        enclosure = Enclosure(enclosure: item["enclosure"])
    }
    
    @objc required public init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.link = aDecoder.decodeObjectForKey("link") as! String
        self.guid = aDecoder.decodeObjectForKey("guid") as! String
        self.enclosure = aDecoder.decodeObjectForKey("enclosure") as! Enclosure
    }
    
    @objc public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.link, forKey: "link")
        aCoder.encodeObject(self.guid, forKey: "guid")
        aCoder.encodeObject(self.enclosure, forKey: "enclosure")
    }
    
}