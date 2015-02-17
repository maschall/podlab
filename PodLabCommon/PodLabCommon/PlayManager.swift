//
//  PlayManager.swift
//  PodLabCommon
//
//  Created by Mark Schall on 2/17/15.
//
//

import Foundation
import AVFoundation

public class PlayManager: NSObject {
    public class var instance : PlayManager {
        struct Static {
            static let instance : PlayManager = PlayManager()
        }
        return Static.instance
    }
    
    private var _player : AVPlayer?
    public var player : AVPlayer {
        get {
            if _player == nil {
                _player = AVPlayer()
            }
            
            return _player!
        }
    }
    
    public var episodePlayed : [(Episode -> Void)] = []
    
    public func playEpisode( episode : Episode ) {
        self.player.replaceCurrentItemWithPlayerItem(AVPlayerItem(URL: episode.path))
        
        for callback in episodePlayed {
            callback( episode )
        }
    }
}
