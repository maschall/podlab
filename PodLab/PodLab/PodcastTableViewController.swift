//
//  PodcastTableViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS

class PodcastTableViewController: UITableViewController {
    
    var podcasts : [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subscriptions = ["http://feeds.serialpodcast.org/serialpodcast",
                        "http://www.majorspoilers.com/media/criticalhit.xml",
                        "http://feeds.thisamericanlife.org/talpodcast"]
        
        for subscription in subscriptions {
            PodSplitter().downloadPodcast(subscription) { (podcast, error) -> Void in
                if let podcast = podcast {
                    self.podcasts.append(podcast)
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcasts.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("podcastCell") as UITableViewCell?
        
        var podcast = self.podcasts[indexPath.item]
        
        cell?.textLabel?.text = podcast.title
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "podcastSelection" {
            var episodeTable = segue.destinationViewController as EpisodeTableViewController
            episodeTable.podcast = self.podcasts[self.tableView.indexPathForSelectedRow()!.item]
        }

        super.prepareForSegue(segue, sender: sender)
    }

}
