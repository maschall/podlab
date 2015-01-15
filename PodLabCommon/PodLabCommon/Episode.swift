//
//  Episode.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

public class Episode: NSManagedObject {

    @NSManaged var guid: String
    @NSManaged public var link: String
    @NSManaged public var title: String
    @NSManaged public var enclosure: Enclosure
    @NSManaged public var podcast: Podcast

}
