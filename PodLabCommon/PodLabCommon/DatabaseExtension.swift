//
//  DatabaseExtension.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/13/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

extension Database {
    func queue() -> Queue {
        var queueRequest = NSFetchRequest(entityName: "Queue")
        
        var queue = self.managedObjectContext?.executeFetchRequest(queueRequest, error: nil)?.first as? Queue
        
        if queue == nil {
            queue = NSEntityDescription.insertNewObjectForEntityForName("Queue", inManagedObjectContext: self.managedObjectContext!) as? Queue
        }
        
        return queue!
    }
    
    func findPodcast( podcast : PodSplitterPodcast ) -> Podcast? {
        var podcastRequest = NSFetchRequest(entityName: "Podcast")
        podcastRequest.predicate = NSPredicate(format: "url = %@", podcast.url)
        
        return self.managedObjectContext?.executeFetchRequest(podcastRequest, error: nil)?.first as? Podcast
    }
    
    func addPodcast( podcast : PodSplitterPodcast ) -> Podcast {
        
        var addedPodcast = findPodcast( podcast )
        
        if addedPodcast == nil {
            var newPodcast = NSEntityDescription.insertNewObjectForEntityForName("Podcast", inManagedObjectContext: self.managedObjectContext!) as! Podcast
            
            newPodcast.url = podcast.url
            newPodcast.title = podcast.title
            newPodcast.link = podcast.link
            newPodcast.podcastDescription = podcast.podcastDescription
            var episodes = podcast.episodes.map({ (episode) -> Episode in
                self.addEpisode(episode)
            })
            newPodcast.setValue(NSSet(array: episodes), forKey: "allEpisodes")
            
            addedPodcast = newPodcast
        } else {
            addedPodcast = updatePodcast( podcast )
        }
        
        return addedPodcast!
    }
    
    func updatePodcast( podcast : PodSplitterPodcast ) -> Podcast {
        var outdatedPodcast = findPodcast( podcast )
        
        if let updatingPodcast = outdatedPodcast {
            if updatingPodcast.url != podcast.url {
                updatingPodcast.url = podcast.url
            }
            if updatingPodcast.title != podcast.title {
                updatingPodcast.title = podcast.title
            }
            if updatingPodcast.link != podcast.link {
                updatingPodcast.link = podcast.link
            }
            if updatingPodcast.podcastDescription != podcast.podcastDescription {
                updatingPodcast.podcastDescription = podcast.podcastDescription
            }
            
            var episodes = podcast.episodes.map({ (episode) -> Episode in
                var updatedEpisode = self.updateEpisode(episode)
                if updatedEpisode.podcast.objectID != updatingPodcast.objectID {
                    updatedEpisode.podcast = updatingPodcast
                }
                return updatedEpisode
            })
                        
            outdatedPodcast = updatingPodcast
        } else {
            outdatedPodcast = addPodcast(podcast)
        }
        
        return outdatedPodcast!
    }
    
    func findEpisode( episode : PodSplitterEpisode ) -> Episode? {
        var episodeRequest = NSFetchRequest(entityName: "Episode")
        episodeRequest.predicate = NSPredicate(format: "guid = %@", episode.guid)
        
        
        return self.managedObjectContext?.executeFetchRequest(episodeRequest, error: nil)?.first as? Episode
    }
    
    func addEpisode( episode : PodSplitterEpisode ) -> Episode {
        var addedEpisode = findEpisode( episode )
        
        if addedEpisode == nil {
            var newEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: self.managedObjectContext!) as! Episode
            
            newEpisode.title = episode.title
            newEpisode.link = episode.link
            newEpisode.guid = episode.guid
            newEpisode.enclosure = addEnclosure(episode.enclosure)
            
            addedEpisode = newEpisode
            
        } else {
            addedEpisode = updateEpisode(episode)
        }
        
        return addedEpisode!
    }
    
    func updateEpisode( episode : PodSplitterEpisode ) -> Episode {
        var outdatedEpisode = findEpisode( episode )
        
        if let updatingEpisode = outdatedEpisode {
            if updatingEpisode.title != episode.title {
                updatingEpisode.title = episode.title
            }
            if updatingEpisode.link != episode.link {
                updatingEpisode.link = episode.link
            }
            if updatingEpisode.guid != episode.guid {
                updatingEpisode.guid = episode.guid
            }
            var updatedEnclosure = updateEnclosure(episode.enclosure)
            if updatingEpisode.enclosure.objectID != updatedEnclosure.objectID {
                updatingEpisode.enclosure = updatedEnclosure
            }
            
            outdatedEpisode = updatingEpisode
        } else {
            outdatedEpisode = addEpisode(episode)
        }
        
        return outdatedEpisode!
    }
    
    func findEnclosure( enclosure : PodSplitterEnclosure ) -> Enclosure? {
        var enclosureRequest = NSFetchRequest(entityName: "Enclosure")
        enclosureRequest.predicate = NSPredicate(format: "url = %@", enclosure.url)
        
        return self.managedObjectContext?.executeFetchRequest(enclosureRequest, error: nil)?.first as? Enclosure
    }
    
    func addEnclosure( enclosure : PodSplitterEnclosure ) -> Enclosure {
        var addedEnclosure = findEnclosure( enclosure )
        
        if addedEnclosure == nil {
            var newEnclosure = NSEntityDescription.insertNewObjectForEntityForName("Enclosure", inManagedObjectContext: self.managedObjectContext!) as! Enclosure
            
            newEnclosure.url = enclosure.url
            newEnclosure.length = enclosure.length
            newEnclosure.type = enclosure.type
            
            addedEnclosure = newEnclosure
        } else {
            addedEnclosure = updateEnclosure(enclosure)
        }
        
        return addedEnclosure!
    }
    
    func updateEnclosure( enclosure : PodSplitterEnclosure ) -> Enclosure {
        var outdatedEnclosure = findEnclosure( enclosure )
        
        if let updatingEnclosure = outdatedEnclosure {
            if updatingEnclosure.url != enclosure.url {
                updatingEnclosure.url = enclosure.url
            }
            if updatingEnclosure.length != enclosure.length {
                updatingEnclosure.length = enclosure.length
            }
            if updatingEnclosure.type != enclosure.type {
                updatingEnclosure.type = enclosure.type
            }
            
            outdatedEnclosure = updatingEnclosure
        } else {
            outdatedEnclosure = addEnclosure(enclosure)
        }
        
        return outdatedEnclosure!
    }
}