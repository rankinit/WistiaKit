//
//  ViewController.swift
//  WistiaKit
//
//  Created by spinosa on 04/05/2016.
//  Copyright © 2016 Wistia, Inc. All rights reserved.
//
//  Non-HLS example video hashedID: 8tjg8ftj2p
//  HLS example video hashedID: 8q4pv4kofw

import UIKit
import WistiaKit

class ViewController: UIViewController {

    //MARK: - Common code 

    // The playerChooser can switch between playback using a presented WistiaVulcanPlayerViewController
    // or, at a lower level, using a WistiaPlayer displayed through a sublayer in a child view.
    @IBOutlet weak var playerChooser: UISegmentedControl!

    @IBOutlet weak var hashedIDTextField: UITextField!

    // Based on the playerChooser's state, first pause/dismiss the other player, then configure and 
    // play using the selected one.
    @IBAction func playTapped(sender: AnyObject) {
        if let hashedID = hashedIDTextField.text {
            switch playerChooser.selectedSegmentIndex {
            case 0:
                wistiaPlayer.pause()

                //Play using WistiaPlayerViewController
                wistiaPlayerVC.replaceCurrentVideoWithVideo(forHashedID: hashedID)
                wistiaPlayerVC.fullscreenEnabled = false
                self.present(wistiaPlayerVC, animated: true, completion: nil)

            case 1:
                self.dismiss(animated: true, completion: nil)

                //Play using WistiaPlayer
                wistiaPlayer.replaceCurrentVideoWithVideo(forHashedID: hashedID)
                wistiaPlayer.play()

            default:
                break
            }
        }
    }

    //MARK: - WistiaPlayerViewController Specific

    let wistiaPlayerVC = WistiaVulcanPlayerViewController(referrer: "https://wistia.com/WistiaKitDemo")

    //MARK: - WistiaPlayer Specific

    let wistiaPlayer = WistiaPlayer(referrer: "WistiaKitDemo", requireHLS: false)
    @IBOutlet weak var playerView: WistiaFlatPlayerView!

    override func viewDidLoad() {
        playerView.wistiaPlayer = wistiaPlayer
    }

}

