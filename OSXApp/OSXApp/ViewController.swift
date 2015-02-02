//
//  ViewController.swift
//  PodLabOSX
//
//  Created by Mark Schall on 1/15/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import Cocoa
import PodLabCommonOSX
import Alamofire

class ViewController: NSViewController {

    @IBOutlet var arrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrayController.managedObjectContext = SubscriptionManager.instance().managedObjectContext
        
        self.arrayController.entityName = SubscriptionManager.instance().podcastFetchRequest.entityName
        self.arrayController.sortDescriptors = SubscriptionManager.instance().podcastFetchRequest.sortDescriptors
        self.arrayController.fetchWithRequest(nil, merge: false, error: nil)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func add(sender: NSButton) {
        var alert = NSAlert()
        alert.messageText = "What podcast would you like to add?"
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Cacnel")
        var textfield = NSTextField(frame: NSRect(x: 0.0, y: 0.0, width: 200.0, height: 24.0))
        alert.accessoryView = textfield
        if alert.runModal() == NSAlertFirstButtonReturn {
            SubscriptionManager.instance().addPodcast(textfield.stringValue)
        }
    }

}

