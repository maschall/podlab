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
            return Database.instance.managedObjectContext!
        }
    }
    
    public var queue : Queue {
        get {
            return Database.instance.queue();
        }
    }
    
    public var podcastFetchRequest : NSFetchRequest;
    
    public init() {
        self.podcastFetchRequest = NSFetchRequest(entityName: "Podcast")
        self.podcastFetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    }
    
    public class var instance : SubscriptionManager {
        struct Static {
            static let instance : SubscriptionManager = SubscriptionManager()
        }
        return Static.instance
    }
    
    public func addPodcast( podcastUrl : String ) {
        PodSplitter().downloadPodcast(podcastUrl) { (podcast, error) -> Void in
            if error == nil {
                Database.instance.addPodcast(podcast!)
                Database.instance.saveContext()
            }
        }
    }
    
    public func removePodcast( podcast : Podcast ) {
        Database.instance.managedObjectContext?.deleteObject(podcast)
        Database.instance.saveContext()
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
            Database.instance.updatePodcast( updatedPodcast )
            Database.instance.saveContext()
            return
        }
    }
}
