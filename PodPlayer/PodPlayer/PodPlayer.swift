//
//  PodPlayer.swift
//  PodPlayer
//
//  Created by Mark Schall on 1/9/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import AVFoundation

var player : AVPlayer?
var progress : ( ( Float ) -> Void )?
var timer : NSTimer?

public class PodPlayer: NSObject {
   
    public class func prepare( file: String ) {
        let url = NSURL(string: file)
        let asset = AVURLAsset.assetWithURL(url) as AVAsset?
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer.playerWithPlayerItem(item) as AVPlayer?
    }
    
    public class func setProgress( callback : ( ( Float ) -> Void )? ) {
        progress = callback
    }
    
    public class func play() {

        if let audioPlayer = player {
            audioPlayer.play()
            timer = NSTimer(timeInterval: 1.0, target: self.classForCoder(), selector: Selector("updateProgress:"), userInfo: nil, repeats: true)
        }
    }
    
    public class func pause() {
        if let audioPlayer = player {
            audioPlayer.pause();
            timer?.invalidate();
        }
    }
    
    public class func position() -> Float {
        var position : Float = 0.0;
        
        if let audioPlayer = player {
            let item = audioPlayer.currentItem;
            position = Float( item.currentTime().value ) / Float( item.duration.value )
        }
        
        return position;
    }
    
    public class func setPosition( position : Float ) {
        if let audioPlayer = player {
            let item = audioPlayer.currentItem;
            let duration = item.duration
            let seekPosition = Float(duration.value) * position;
            let seekTime = CMTime(value: CMTimeValue(seekPosition), timescale: duration.timescale, flags: duration.flags, epoch: duration.epoch)
            audioPlayer.seekToTime(seekTime)
        }
    }
    
    public class func volume() -> Float {
        var volume : Float = 0.0;
        
        if let audioPlayer = player {
            volume = audioPlayer.volume
        }
        
        return volume;
    }
    
    public class func setVolume( volume : Float ) {
        if let audioPlayer = player {
            audioPlayer.volume = volume
        }
    }
    
    class func updateProgress( sender : AnyObject? ) {
        if let callback = progress {
            callback(self.position())
        }
    }
}
