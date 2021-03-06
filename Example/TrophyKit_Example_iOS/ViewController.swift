//
//  ViewController.swift
//  TrophyKit
//
//  Created by Yubo Qin on 06/24/2021.
//  Copyright (c) 2021 Yubo Qin. All rights reserved.
//

import UIKit
import TrophyKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

