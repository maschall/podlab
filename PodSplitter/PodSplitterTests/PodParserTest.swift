//
//  PodParserTest.swift
//  PodSplitter
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import XCTest
import Nimble

class PodParserTest: XCTestCase {

    class Podcast {
        
        var title : String?
        
        class func parse( xml : String ) -> Podcast {
            var podcast = Podcast()
            
            podcast.title = "test"
            
            return podcast;
        }
        
    }
    
    var podcast : Podcast?;
    
    override func setUp() {
        super.setUp()
        
        let path = NSBundle(forClass: self.classForCoder).pathForResource("serial-test", ofType: "rss");
        
        var error: NSError?;
        
        if let actualPath = path {
            var testRssFeed = String(contentsOfFile: actualPath, encoding: NSUTF8StringEncoding, error: &error)!
            
            podcast = Podcast.parse(testRssFeed);
        }
    }
    
    func testWhenParsingPodcastXml_WillParseTitle() {
        expect{self.podcast?.title!}.to(equal("test"));
    }

}
