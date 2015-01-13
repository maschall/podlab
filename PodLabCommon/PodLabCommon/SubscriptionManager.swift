//
//  SubscriptionManager.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/12/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS

let manager = SubscriptionManager()

public class SubscriptionManager: NSObject {
    public var podcasts : [Podcast]
    
    public override init() {
        self.podcasts = FilePersistence().load("subscription.plist") as? [Podcast] ?? []
        
        super.init()
    }
    
    public class func instance() -> SubscriptionManager {
        return manager
    }
    
    func persist() {
        FilePersistence().persist(self.podcasts, key: "subscription.plist")
    }
    
    public func addPodcast( podcast : Podcast ) {
        self.podcasts.append(podcast)
        
        self.persist()
    }
    
    public func removePodcast( index : Int ) {
        self.podcasts.removeAtIndex( index )
        
        self.persist()
    }
    
    public func movePodcast( source : Int, destination : Int ) {
        let podcast = self.podcasts.removeAtIndex(source)
        self.podcasts.insert(podcast, atIndex: destination)
        
        self.persist()
    }
    
    public func updateAll(callback : (NSError?) -> Void) {
        var error : NSError? = nil
        
        for podcast in self.podcasts {
            update(podcast) {
                (updateError) -> Void in
                if let updateError = updateError {
                    error = updateError
                }
            }
        }
        
        callback(error)
    }
    
    public func update( podcast : Podcast, callback : (NSError?) -> Void ) {
        PodSplitter().updatePodcast( podcast, callback )
        
        self.persist()
    }
}
