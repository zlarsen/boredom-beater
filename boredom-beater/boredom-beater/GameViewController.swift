//
//  GameViewController.swift
//  boredom-beater
//
//  Created by Zach Larsen on 6/3/16.
//  Copyright © 2016 Zach Larsen. All rights reserved.
//

import UIKit

let gameLength = 10.0

class GameViewController: UIViewController {
    
    var timer = NSTimer()
    var press = UIButton()
    var green = UIButton()
    var restartGameButton = UIButton()
    var newHiScoreLabel = UILabel()
    var gameOverView =  UIView()
    var gameInPlay = false
    var clickCounter = 0
    var firstTimeClicked = true
    var counter = gameLength
    let savedScores = NSUserDefaults.standardUserDefaults()
    var hiscore = 0
    var newHiScore = false
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        green.hidden = true
        green.frame = CGRect(x: self.view.bounds.width/2-green.bounds.width, y: green.bounds.height, width: 100, height: 100)
        green.setTitle("+5 Sec", forState: .Normal)
        green.setTitleColor(UIColor.greenColor(), forState: .Normal)
        green.addTarget(self, action: #selector(GameViewController.greenButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        press.frame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height/2, width: 100, height: 100)
        press.setTitle("Punch", forState: .Normal)
        press.setTitleColor(UIColor.redColor(), forState: .Normal)
        press.addTarget(self, action: #selector(GameViewController.pressButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(green)
        self.view.addSubview(press)
        
        gameOverView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        gameOverView.hidden = true
        gameOverView.backgroundColor = UIColor.whiteColor()
        
        
        restartGameButton.frame = CGRect(x: gameOverView.frame.width/2-75, y: gameOverView.frame.height/2-15, width: 150, height: 30)
        restartGameButton.setTitle("Restart Game", forState: .Normal)
        restartGameButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        restartGameButton.addTarget(self, action: #selector(GameViewController.restartGameButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        newHiScoreLabel.hidden = true
        newHiScoreLabel.textColor = UIColor.blueColor()
        newHiScoreLabel.frame = CGRect(x: gameOverView.frame.width/2-90, y: gameOverView.frame.height/2-65, width: 180, height: 30)

        
        
        self.view.addSubview(gameOverView)
        gameOverView.addSubview(restartGameButton)
        gameOverView.addSubview(newHiScoreLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func startGame() {
        print("Game has started")
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        gameInPlay = true
//        gameLoop()
    }
    
    func updateCounter() {
        counter -= 0.1
        counter = Double(round(10*counter)/10)
        if (counter == 0.0) {
            timer.invalidate()
            gameOver()
        }
        timerLabel.text = "Time \(counter)"
    }
    
    func gameOver() {
        print("game over!")
        gameInPlay = false
        press.hidden = true
        green.hidden = true
        gameOverView.hidden = false
        if (clickCounter > hiscore) {
            newHiScore = true
            newHiScoreLabel.hidden = false
            newHiScoreLabel.text = "Your New Hiscore is: \(clickCounter)"
            savedScores.setValue(clickCounter, forKey: "hiscore")
        }
    }
    
    func gameAction() {
        randomButtonPlacement(press)
        if (clickCounter % 10 == 0 && clickCounter != 0) {
            randomButtonPlacement(green)
            green.hidden = false
        }
        
    }
    
    func randomButtonPlacement(button : UIButton) {
        let x = CGFloat(arc4random_uniform(UInt32(self.view.bounds.width-button.bounds.width)))
        let y = CGFloat(arc4random_uniform(UInt32(self.view.bounds.height-button.bounds.height-50.0)))
        button.frame.origin = CGPoint(x: x, y: y)
    }
    
    func restartGame() {
        gameOverView.hidden = true
        press.hidden = false
        gameInPlay = true
        counter = gameLength
        clickCounter = 0
        newHiScoreLabel.hidden = true
        score.text = "Score 0"
        startGame()
    }
    
    func pressButtonAction(sender:UIButton!) {
        if (firstTimeClicked == true) {
            firstTimeClicked = false
            startGame()
        } else {
            clickCounter += 1
            score.text = "Score \(clickCounter)"
        }
        gameAction()
    }
    
    func greenButtonAction(sender:UIButton!) {
        counter += 5.0
        green.hidden = true
    }
    
    func restartGameButtonAction(sender:UIButton!) {
        restartGame()
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

