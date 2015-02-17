//
//  MainTabBarController.swift
//  iOSApp
//
//  Created by Mark Schall on 2/17/15.
//  Copyright (c) 2015 Detroit Labs. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import PodLabCommoniOS

class MainTabBarController: UITabBarController {

    var nowPlaying : AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nowPlaying = self.viewControllers![2] as? AVPlayerViewController;
        nowPlaying?.player = PlayManager.instance.player
        
        PlayManager.instance.episodePlayed += [{ (episode : Episode ) -> Void in
            self.selectedViewController = self.nowPlaying
        }]
    }

}
