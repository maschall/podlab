//
//  QueueExtension.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

extension Queue {
    public func addEpisode( episode : Episode ) {
        self.mutableOrderedSetValueForKey("episodes").addObject(episode)
    }
    
    public func removeEpisode( episode : Episode ) {
        self.mutableOrderedSetValueForKey("episodes").removeObject(episode)
    }
    
    public func moveEpisode( episode : Episode, toIndex : Int ) {
        self.removeEpisode( episode );
        self.insertEpisode( episode, atIndex: toIndex )
    }
    
    public func episodeAtIndex( index : Int ) -> Episode {
        return self.episodes.objectAtIndex(index) as! Episode
    }
    
    public func insertEpisode( episode : Episode, atIndex : Int ) {
        self.mutableOrderedSetValueForKey("episodes").insertObject(episode, atIndex: atIndex)
    }
}