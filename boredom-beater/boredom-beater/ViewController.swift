//
//  ViewController.swift
//  boredom-beater
//
//  Created by Zach Larsen on 6/3/16.
//  Copyright © 2016 Zach Larsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var highScoreLabel: UILabel!
    let savedScores = NSUserDefaults.standardUserDefaults()
    var hiscore = 0
    

    @IBAction func startGameButton(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("game")
        resultViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    @IBAction func instructionsButton(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("Instructions")
        resultViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(resultViewController, animated:true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hiscore = initializeCounters("hiscore")
        highScoreLabel.text = "High Score: \(hiscore)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func initializeCounters(name: String) -> Int {
        let countVal = savedScores.integerForKey(name)
        if (countVal == 0){
            savedScores.setInteger(0, forKey: name)
        } else {
        }
        return countVal
    }
}

