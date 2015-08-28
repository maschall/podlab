//
//  EpisodeExtension.swift
//  PodLabCommon
//
//  Created by Mark Schall on 2/3/15.
//
//

import Foundation

#if os(iOS)
import MobileCoreServices
#else
import CoreServices
#endif
    
    
public extension Episode {
    public var path : NSURL {
        get {
            return self.downloaded ? self.downloadFilePath : NSURL(string: self.enclosure.url)!;
        }
    }
    
    public var downloaded : Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(self.downloadFilePath.path!)
    }
    
    var downloadFolderPath : NSURL {
        get {
            struct Static {
                static let baseFolderPath = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first as! NSURL
            }
            
            var folder = Static.baseFolderPath.URLByAppendingPathComponent(sanitizeFileName(self.podcast.title))
            
            NSFileManager.defaultManager().createDirectoryAtURL(folder, withIntermediateDirectories: true, attributes: nil, error: nil)
            
            return folder;
        }
    }
    
    var downloadFilePath : NSURL {
        get {
            var uttype = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, self.enclosure.type, nil);
            var utpt = UTTypeCopyPreferredTagWithClass(uttype.takeRetainedValue(), kUTTagClassFilenameExtension);
            
            return self.downloadFolderPath.URLByAppendingPathComponent(sanitizeFileName(self.guid)).URLByAppendingPathExtension(utpt.takeRetainedValue() as String)
        }
    }
    
    func sanitizeFileName( path : String ) -> String {
        var invalidChars = NSCharacterSet(charactersInString: "/\\?%*|\"<>")
        return "".join(path.componentsSeparatedByCharactersInSet(invalidChars))
    }
}