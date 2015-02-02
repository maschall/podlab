//
//  Enclosure.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

public class Enclosure: NSCoding {
    
    public var url : String
    public var length : Int
    public var type : String
    
    init(enclosure: XMLIndexer) {
        url = enclosure.element?.attributes["url"] ?? "";
        type = enclosure.element?.attributes["type"] ?? "";
        length = enclosure.element?.attributes["length"]?.toInt() ?? 0
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.url = aDecoder.decodeObjectForKey("url") as String
        self.type = aDecoder.decodeObjectForKey("type") as String
        self.length = aDecoder.decodeObjectForKey("length") as Int
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.url, forKey: "url")
        aCoder.encodeObject(self.type, forKey: "type")
        aCoder.encodeObject(self.length, forKey: "length")
    }
    
}
