//
//  Queue.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation
import CoreData

public class Queue: NSManagedObject {

    @NSManaged public var episodes: NSOrderedSet

}
