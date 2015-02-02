//
//  PodcastTableViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/8/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodLabCommoniOS
import CoreData

class PodcastTableViewController: UITableViewController, UIAlertViewDelegate, NSFetchedResultsControllerDelegate {
    
    var podcastFetchedResultsController : NSFetchedResultsController

    required init(coder aDecoder: NSCoder) {
        var subscriptionManager = SubscriptionManager.instance()

        self.podcastFetchedResultsController = NSFetchedResultsController(fetchRequest: subscriptionManager.podcastFetchRequest, managedObjectContext:subscriptionManager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.podcastFetchedResultsController.performFetch(nil)
        
        super.init(coder: aDecoder)

        self.podcastFetchedResultsController.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("add:"))
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func sectionInfo( section : Int ) -> NSFetchedResultsSectionInfo {
        return self.podcastFetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionInfo( section ).numberOfObjects
    }
    
    func podcastAt( indexPath : NSIndexPath ) -> Podcast {
        return sectionInfo( indexPath.section ).objects[indexPath.item] as Podcast
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("podcastCell") as UITableViewCell?
        
        var podcast = podcastAt( indexPath )
        
        cell?.textLabel?.text = podcast.title
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        SubscriptionManager.instance().removePodcast(podcastAt(indexPath))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "podcastSelection" {
            var episodeTable = segue.destinationViewController as EpisodeTableViewController
            episodeTable.podcast = podcastAt(self.tableView.indexPathForSelectedRow()!)
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
            SubscriptionManager.instance().addPodcast(textfield.text)
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        default:
            self.tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
}
