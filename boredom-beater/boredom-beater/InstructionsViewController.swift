//
//  ViewController.swift
//  boredom-beater
//
//  Created by Zach Larsen on 6/3/16.
//  Copyright © 2016 Zach Larsen. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {
    
    @IBAction func homeScreen(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeScreen")
        resultViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }
    @IBAction func playGame(sender: AnyObject) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewControllerWithIdentifier("game")
        resultViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(resultViewController, animated:true, completion:nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

