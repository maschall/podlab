//
//  EpisodeTableViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/9/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS
import AVKit
import AVFoundation

class EpisodeTableViewController: UITableViewController {

    var podcast: Podcast?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcast?.episodes.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("episodeCell") as UITableViewCell?
        
        var episode = self.podcast!.episodes[indexPath.item]
        
        cell?.textLabel?.text = episode.title
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "episodeSelected" {
            var episode = self.podcast!.episodes[self.tableView.indexPathForSelectedRow()!.item]
            
            var player = segue.destinationViewController as AVPlayerViewController
            player.player = AVPlayer(URL: NSURL(string: episode.enclosure.url))
            player.player.play()
        }
        
        super.prepareForSegue(segue, sender: sender)
    }
    
}
