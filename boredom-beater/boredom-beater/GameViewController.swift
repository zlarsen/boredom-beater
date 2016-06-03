//
//  GameViewController.swift
//  boredom-beater
//
//  Created by Zach Larsen on 6/3/16.
//  Copyright © 2016 Zach Larsen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer = NSTimer()
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var green: UIButton!
    @IBOutlet var press: UIButton!
    
    @IBAction func pressButton(sender: AnyObject) {
        startGame()
    }
    
    @IBAction func greenButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        green.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGame() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(GameViewController.gameOver), userInfo: nil, repeats: true)
        print("Game has started")
    }
    
    func gameOver() {
        
    }
}

