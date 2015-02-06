//
//  Enclosure.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

class Enclosure: NSManagedObject {

    @NSManaged var length: NSNumber
    @NSManaged var type: String
    @NSManaged var url: String
    @NSManaged var episode: Episode

}
