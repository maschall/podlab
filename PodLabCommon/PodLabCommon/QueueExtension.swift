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
    
    public func insertEpisode( episode : Episode, atIndex : Int ) {
        self.mutableOrderedSetValueForKey("episodes").insertObject(episode, atIndex: atIndex)
    }
}