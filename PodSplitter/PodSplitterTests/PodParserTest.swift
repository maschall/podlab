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
import PodSplitteriOS

class PodParserTest: XCTestCase {

    class Podcast : NSObject {
        
        var title : String
        var link : String
        var podcastDescription : String
        var episodes : Array<Episode>;
        
        init(xml: String) {
            var podcast = SWXMLHash.parse(xml);
            
            var channel = podcast["rss"]["channel"]
            
            title = channel["title"].element?.text ?? ""
            link = channel["link"].element?.text ?? ""
            podcastDescription = channel["description"].element?.text ?? ""
            
            episodes = channel["item"].all.map { item in Episode( item: item ) }
            
            super.init()
        }
    }
    
    class Episode : NSObject {
        
        var title : String
        var link : String
        var enclosure: Enclosure
        
        init(item: XMLIndexer) {
            title = item["title"].element?.text ?? ""
            link = item["link"].element?.text ?? ""
            enclosure = Enclosure(enclosure: item["enclosure"])
            
            super.init()
        }
        
    }
    
    class Enclosure: NSObject {
    
        var url : String
        var length : Int
        var type : String
        
        init(enclosure: XMLIndexer) {
            url = enclosure.element?.attributes["url"] ?? "";
            type = enclosure.element?.attributes["type"] ?? "";
            length = enclosure.element?.attributes["length"]?.toInt() ?? 0
            
            super.init()
        }
        
    }
    
    var podcast : Podcast?;
    
    override func setUp() {
        super.setUp()
        
        let path = NSBundle(forClass: self.classForCoder).pathForResource("serial-test", ofType: "rss");
        
        var error: NSError?;
        
        if let actualPath = path {
            var testRssFeed = String(contentsOfFile: actualPath, encoding: NSUTF8StringEncoding, error: &error)!
            
            podcast = Podcast(xml: testRssFeed);
        }
    }
    
    func testWhenParsingPodcastXml_WillParseTitle() {
        expect{self.podcast?.title}.to(equal("Serial"));
    }

    func testWhenParsingPodcastXml_WillParseLink() {
        expect{self.podcast?.link}.to(equal("http://serialpodcast.org"));
    }
    
    func testWhenParsingPodcastXml_WillParseDescription() {
        expect{self.podcast?.podcastDescription}.to(equal("Serial is a new podcast from the creators of This American Life, hosted by Sarah Koenig. Serial unfolds one story - a true story - over the course of a whole season. The show follows the plot and characters wherever they lead, through many surprising twists and turns. Sarah won't know what happens at the end of the story until she gets there, not long before you get there with her. Each week she'll bring you the latest chapter, so it's important to listen in, starting with Episode 1. New episodes are released on Thursday mornings. Serial, like This American Life, is a production of WBEZ Chicago."));
    }
    
    func testWhenParsingPodcastXml_WillParseEpisodes() {
        expect{self.podcast?.episodes.count}.to(equal(12));
    }
    
    func testWhenParsingPodcastXml_WillParseEpisodeTitle() {
        expect{self.podcast?.episodes.first?.title}.to(equal("Episode 12: What We Know"));
    }
    
    func testWhenParsingPodcastXml_WillParseEpisodeLink() {
        expect{self.podcast?.episodes.first?.link}.to(equal("http://feeds.serialpodcast.org/~r/serialpodcast/~3/_LnOrNUV5n4/"));
    }
}
