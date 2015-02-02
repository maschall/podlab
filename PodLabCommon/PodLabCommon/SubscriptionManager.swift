//
//  SubscriptionManager.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/12/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

#if os(iOS)
    import PodSplitteriOS
    #else
    import PodSplitterOSX
#endif

import CoreData

let manager = SubscriptionManager()

public class SubscriptionManager {
    
    public var managedObjectContext : NSManagedObjectContext {
        get {
            return Database.sharedInstance.managedObjectContext!
        }
    }
    
    public var podcastFetchRequest : NSFetchRequest;
    
    public init() {
        self.podcastFetchRequest = NSFetchRequest(entityName: "Podcast")
        self.podcastFetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    }
    
    public class func instance() -> SubscriptionManager {
        return manager
    }
    
    public func addPodcast( podcastUrl : String ) {
        PodSplitter().downloadPodcast(podcastUrl) { (podcast, error) -> Void in
            if error == nil {
                Database.sharedInstance.addPodcast(podcast!)
                Database.sharedInstance.saveContext()
            }
        }
    }
    
    public func removePodcast( podcast : Podcast ) {
        Database.sharedInstance.managedObjectContext?.deleteObject(podcast)
        Database.sharedInstance.saveContext()
    }
    
    public func updateAll(callback : (NSError?) -> Void) {
        var error : NSError? = nil
        
        var podcasts = self.managedObjectContext.executeFetchRequest(self.podcastFetchRequest, error: nil) as [Podcast]
        
        for podcast in podcasts {
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
        var updatedPodcast = PodSplitterPodcast( podcast: podcast )
        PodSplitter().updatePodcast( updatedPodcast ) { error in
            Database.sharedInstance.updatePodcast( updatedPodcast )
            Database.sharedInstance.saveContext()
            return
        }
    }
}
