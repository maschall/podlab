//
//  PodcastExtension.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/13/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

#if os(iOS)
    import PodSplitteriOS
    typealias PodSplitterPodcast = PodSplitteriOS.Podcast
    typealias PodSplitterEpisode = PodSplitteriOS.Episode
    typealias PodSplitterEnclosure = PodSplitteriOS.Enclosure
    #else
    import PodSplitterOSX
    typealias PodSplitterPodcast = PodSplitterOSX.Podcast
    typealias PodSplitterEpisode = PodSplitterOSX.Episode
    typealias PodSplitterEnclosure = PodSplitterOSX.Enclosure
#endif

extension PodSplitterPodcast {
    convenience init( podcast : Podcast ) {
        self.init(url: podcast.url)
    }
}

extension Podcast {
    public func addEpisode( episode : Episode ) {
        self.mutableArrayValueForKey("episodes").addObject(episode)
    }
    
    public func removeEpisode( episode : Episode ) {
        self.mutableArrayValueForKey("episodes").removeObject(episode)
    }
    
    public var episodes : [Episode] {
        get {
            return self.allEpisodes.sortedArrayUsingDescriptors([NSSortDescriptor(key: "guid", ascending: false)]) as [Episode]
        }
    }
}