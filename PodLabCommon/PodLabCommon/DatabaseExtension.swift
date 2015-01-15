//
//  DatabaseExtension.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/13/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData
import PodSplitteriOS

extension Database {
    func findPodcast( url : String ) -> Podcast? {
        var podcastRequest = NSFetchRequest(entityName: "Podcast")
        podcastRequest.predicate = NSPredicate(format: "url = %@", url)
        
        return Database.sharedInstance.managedObjectContext?.executeFetchRequest(podcastRequest, error: nil)?.first as Podcast?
    }
    
    func addPodcast( podcast : PodSplitteriOS.Podcast ) -> Podcast {
        
        var addedPodcast = findPodcast( podcast.url )
        
        if addedPodcast == nil {
            var newPodcast = NSEntityDescription.insertNewObjectForEntityForName("Podcast", inManagedObjectContext: Database.sharedInstance.managedObjectContext!) as Podcast
            
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
    
    func updatePodcast( podcast : PodSplitteriOS.Podcast ) -> Podcast {
        var outdatedPodcast = findPodcast( podcast.url )
        
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
    
    func findEpisode( episode : PodSplitteriOS.Episode ) -> Episode? {
        var episodeRequest = NSFetchRequest(entityName: "Episode")
        episodeRequest.predicate = NSPredicate(format: "guid = %@", episode.guid)
        
        
        return Database.sharedInstance.managedObjectContext?.executeFetchRequest(episodeRequest, error: nil)?.first as Episode?
    }
    
    func addEpisode( episode : PodSplitteriOS.Episode ) -> Episode {
        var addedEpisode = findEpisode( episode )
        
        if addedEpisode == nil {
            var newEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episode", inManagedObjectContext: Database.sharedInstance.managedObjectContext!) as Episode
            
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
    
    func updateEpisode( episode : PodSplitteriOS.Episode ) -> Episode {
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
    
    func findEnclosure( enclosure : PodSplitteriOS.Enclosure ) -> Enclosure? {
        var enclosureRequest = NSFetchRequest(entityName: "Enclosure")
        enclosureRequest.predicate = NSPredicate(format: "url = %@", enclosure.url)
        
        return Database.sharedInstance.managedObjectContext?.executeFetchRequest(enclosureRequest, error: nil)?.first as Enclosure?
    }
    
    func addEnclosure( enclosure : PodSplitteriOS.Enclosure ) -> Enclosure {
        var addedEnclosure = findEnclosure( enclosure )
        
        if addedEnclosure == nil {
            var newEnclosure = NSEntityDescription.insertNewObjectForEntityForName("Enclosure", inManagedObjectContext: Database.sharedInstance.managedObjectContext!) as Enclosure
            
            newEnclosure.url = enclosure.url
            newEnclosure.length = enclosure.length
            newEnclosure.type = enclosure.type
            
            addedEnclosure = newEnclosure
        } else {
            addedEnclosure = updateEnclosure(enclosure)
        }
        
        return addedEnclosure!
    }
    
    func updateEnclosure( enclosure : PodSplitteriOS.Enclosure ) -> Enclosure {
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