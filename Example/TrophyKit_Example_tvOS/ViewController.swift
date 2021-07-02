//
//  ViewController.swift
//  TrophyKit Example tvOS
//
//  Created by Yubo Qin on 7/1/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import TrophyKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showTrophy() {
        let trophy = Trophy(configuration: TrophyConfiguration(size: .medium))
        trophy.show(from: self,
                    title: "Achievement Unlocked",
                    subtitle: "You have added a new skill!",
                    iconSymbol: "gamecontroller.fill",
                    trophyIconSymbol: "rosette")
    }


}

