//
//  FilePersistence.swift
//  PodLabCommon
//
//  Created by Mark Schall on 1/12/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Foundation

class FilePersistence: NSObject {
    
    func filepath( key : String ) -> String {
        var path = ""
        
        if let directory = NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.ApplicationSupportDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: true, error: nil) {
            path = directory.URLByAppendingPathComponent(key).path!
        }
        return path
    }
    
    func persist(thing: AnyObject, key: String) {
        NSKeyedArchiver.archiveRootObject(thing, toFile: filepath(key))
    }
    
    func load(key: String) -> AnyObject? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(filepath(key))
    }
    
}
