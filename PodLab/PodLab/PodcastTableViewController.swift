//
//  PodcastTableViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS
import PodPlayer

class PodcastTableViewController: UITableViewController {
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PodSplitter().downloadPodcast("http://feeds.serialpodcast.org/serialpodcast") { (podcast, error) -> Void in
            self.podcast = podcast
            self.tableView.reloadData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcast?.episodes.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("episodeCell") as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "episodeCell")
        }
        
        var episode = self.podcast!.episodes[indexPath.row]
        
        cell?.textLabel?.text = episode.title
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var episode = self.podcast!.episodes[indexPath.row]
        
        var enclosure = episode.enclosure
        
        PodPlayer.prepare(enclosure.url)
        PodPlayer.play()
        
        self.presentViewController(PlayerViewController(), animated: true, completion: nil)
    }

}
