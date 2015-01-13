//
//  PodcastTableViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodSplitteriOS
import PodLabCommoniOS

class PodcastTableViewController: UITableViewController, UIAlertViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("add:"))
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SubscriptionManager.instance().podcasts.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("podcastCell") as UITableViewCell?
        
        var podcast = SubscriptionManager.instance().podcasts[indexPath.item]
        
        cell?.textLabel?.text = podcast.title
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        SubscriptionManager.instance().removePodcast(indexPath.item)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        SubscriptionManager.instance().movePodcast(sourceIndexPath.item, destination: destinationIndexPath.item)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "podcastSelection" {
            var episodeTable = segue.destinationViewController as EpisodeTableViewController
            episodeTable.podcast = SubscriptionManager.instance().podcasts[self.tableView.indexPathForSelectedRow()!.item]
        }

        super.prepareForSegue(segue, sender: sender)
    }

    func add( sender : UIBarButtonItem ) {
        let alert = UIAlertView(title: "Add Podcast", message: "What podcast would you like to subscribe to?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Subscribe")
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            let textfield = alertView.textFieldAtIndex(0)!
            PodSplitter().downloadPodcast(textfield.text, callback: { (podcast, error) -> Void in
                if let error = error {
                    UIAlertView(title: "Error", message: error.description, delegate: nil, cancelButtonTitle: "OK").show()
                } else if let podcast = podcast {
                    SubscriptionManager.instance().addPodcast(podcast)
                    self.tableView.reloadData()
                }
            })
        }
    }
}
