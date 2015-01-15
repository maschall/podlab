//
//  Podcast.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

public class Podcast: NSManagedObject {

    @NSManaged public var link: String
    @NSManaged public var podcastDescription: String
    @NSManaged public var title: String
    @NSManaged var url: String
    @NSManaged var allEpisodes: NSSet

}
