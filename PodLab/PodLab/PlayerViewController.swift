//
//  PlayerViewController.swift
//  PodLab
//
//  Created by Mark Schall on 1/9/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import PodPlayer

class PlayerViewController: UIViewController {

    @IBOutlet weak var position: UISlider!
    
    @IBOutlet weak var volume: UISlider!
    
    override init() {
        super.init(nibName: "PlayerViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PodPlayer.setProgress { (duration) -> Void in
            self.position.value = duration;
        }
        
        position.value = PodPlayer.position()
        volume.value = PodPlayer.volume()
    }
    
    @IBAction func volumeChanged(sender: UISlider) {
        PodPlayer.setVolume(sender.value)
    }
    
    @IBAction func positionChanged(sender: UISlider) {
        PodPlayer.setPosition(sender.value)
    }

}
