//
//  SubscriptionManager.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/12/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS
import CoreData

let manager = SubscriptionManager()

public class SubscriptionManager: NSObject {
    
    public var podcastFetchedResultsController : NSFetchedResultsController
    
    public override init() {
        let podcastFetchRequest = NSFetchRequest(entityName: "Podcast")
        podcastFetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        self.podcastFetchedResultsController = NSFetchedResultsController(fetchRequest: podcastFetchRequest, managedObjectContext: Database.sharedInstance.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        self.podcastFetchedResultsController.performFetch(nil)
        
        super.init()
    }
    
    public class func instance() -> SubscriptionManager {
        return manager
    }
    
    public func addPodcast( podcastUrl : String ) {
        PodSplitter().downloadPodcast(podcastUrl) { (podcast, error) -> Void in
            Database.sharedInstance.addPodcast(podcast!)
            Database.sharedInstance.saveContext()
            return
        }
    }
    
    public func removePodcast( podcast : Podcast ) {
        Database.sharedInstance.managedObjectContext?.deleteObject(podcast)
        Database.sharedInstance.saveContext()
    }
    
    public func updateAll(callback : (NSError?) -> Void) {
        var error : NSError? = nil
        
        for section in self.podcastFetchedResultsController.sections as [NSFetchedResultsSectionInfo] {
            for podcast in section.objects as [Podcast] {
                update(podcast) {
                    (updateError) -> Void in
                    if let updateError = updateError {
                        error = updateError
                    }
                }
            }
        }
        
        callback(error)
    }
    
    public func update( podcast : Podcast, callback : (NSError?) -> Void ) {
        var updatedPodcast = PodSplitteriOS.Podcast( podcast: podcast )
        PodSplitter().updatePodcast( updatedPodcast ) { error in
            Database.sharedInstance.updatePodcast( updatedPodcast )
            Database.sharedInstance.saveContext()
            return
        }
    }
}
