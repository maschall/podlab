//
//  Enclosure.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit

public class Enclosure: NSObject {
    
    public var url : String
    public var length : Int
    public var type : String
    
    init(enclosure: XMLIndexer) {
        url = enclosure.element?.attributes["url"] ?? "";
        type = enclosure.element?.attributes["type"] ?? "";
        length = enclosure.element?.attributes["length"]?.toInt() ?? 0
        
        super.init()
    }
    
}
