//
//  Enclosure.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

public class Enclosure: NSManagedObject {

    @NSManaged public var length: NSNumber
    @NSManaged public var type: String
    @NSManaged public var url: String
    @NSManaged public var episode: Episode

}
