//
//  GameViewController.swift
//  boredom-beater
//
//  Created by Zach Larsen on 6/3/16.
//  Copyright © 2016 Zach Larsen. All rights reserved.
//

import UIKit
import AdSupport

let gameLength = 10.0
let diffLevels: [Int] = [10,25,50,75,100,125,150,175,200,225,250,275,300,325,350]
let decreaseValues: [Double] = [0.11,0.13,0.15,0.17,0.19,0.21,0.23,0.25,0.27,0.29,0.31,0.33,0.35,0.37,0.39]

class GameViewController: UIViewController, FlurryAdBannerDelegate {
    
    let adBanner =  FlurryAdBanner(space: "BOREDOMBEATERAD")
    
    var timer = NSTimer()
    var press = UIButton()
    var green = UIButton()
    var restartGameButton = UIButton()
    var newHiScoreLabel = UILabel()
    var hiScoreLabel = UILabel()
    var gameOverView =  UIView()
    var tombstone = UIImageView()
    var gameInPlay = false
    var clickCounter = 0
    var firstTimeClicked = true
    var counter = gameLength
    let savedScores = NSUserDefaults.standardUserDefaults()
    var hiscore = 0
    var newHiScore = false
    var counterDec = 0.1
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        green.hidden = true
        green.frame = CGRect(x: self.view.bounds.width/2-green.bounds.width, y: green.bounds.height, width: 100, height: 100)
        green.setBackgroundImage(UIImage(named: "green-button.png"), forState: .Normal)
        green.setTitleColor(UIColor.greenColor(), forState: .Normal)
        green.addTarget(self, action: #selector(GameViewController.greenButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        press.frame = CGRect(x: self.view.bounds.width/2-50, y: self.view.bounds.height/2-50, width: 100, height: 100)
        press.setBackgroundImage(UIImage(named: "red-button.png"), forState: .Normal)
        press.setTitleColor(UIColor.redColor(), forState: .Normal)
        press.addTarget(self, action: #selector(GameViewController.pressButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(green)
        self.view.addSubview(press)
        
        gameOverView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        gameOverView.backgroundColor = UIColor.whiteColor()
        gameOverView.hidden = true
        
        restartGameButton.frame = CGRect(x: gameOverView.frame.width/2-75, y: gameOverView.frame.height/2-15, width: 150, height: 30)
        restartGameButton.setTitle("Restart Game", forState: .Normal)
        restartGameButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        restartGameButton.addTarget(self, action: #selector(GameViewController.restartGameButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        newHiScoreLabel.hidden = true
        newHiScoreLabel.textColor = UIColor.redColor()
        newHiScoreLabel.adjustsFontSizeToFitWidth = true
        score.adjustsFontSizeToFitWidth = true
        newHiScoreLabel.frame = CGRect(x: gameOverView.frame.width/2-90, y: gameOverView.frame.height/2-95, width: 180, height: 30)
        
        hiScoreLabel.textColor = UIColor.blueColor()
        hiScoreLabel.adjustsFontSizeToFitWidth = true
        hiScoreLabel.frame = CGRect(x: gameOverView.frame.width/2-40, y: gameOverView.frame.height/2-65, width: 80, height: 30)

        tombstone.frame = CGRect(x: gameOverView.frame.width/2-180, y: gameOverView.frame.height/2+20, width: 400, height: 200)
        tombstone.image = UIImage(named: "tombstone.png")
        
        self.view.addSubview(gameOverView)
        gameOverView.addSubview(newHiScoreLabel)
        gameOverView.addSubview(hiScoreLabel)
        gameOverView.addSubview(restartGameButton)
        gameOverView.addSubview(tombstone)
        
        hiscore = initializeCounters("hiscore")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        adBanner.adDelegate = self
        adBanner.fetchAdForFrame(self.gameOverView.frame)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func startGame() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        gameInPlay = true
    }
    
    func updateCounter() {
        if (diffLevels.contains(clickCounter)) {
            counterDec = decreaseValues[clickCounter]
        }
        counter -= counterDec
        counter = Double(round(10*counter)/10)
        if (counter <= 0.0) {
            timer.invalidate()
            gameOver()
        }
        timerLabel.text = "Time \(counter)"
    }
    
    func gameOver() {
        gameInPlay = false
        press.hidden = true
        green.hidden = true
        gameOverView.hidden = false
        if (clickCounter > hiscore) {
            newHiScore = true
            newHiScoreLabel.hidden = false
            newHiScoreLabel.text = "Your New Hiscore is: \(clickCounter)"
            savedScores.setValue(clickCounter, forKey: "hiscore")
            hiscore = initializeCounters("hiscore")
        }
        hiScoreLabel.text = "Hiscore: \(hiscore)"
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
        counter = gameLength
        clickCounter = 0
        newHiScoreLabel.hidden = true
        score.text = "Score 0"
        timerLabel.text = "Time 10.0"
        counterDec = 0.1
        press.frame.origin = CGPoint(x: self.view.bounds.width/2-50, y: self.view.bounds.height/2-50)
        firstTimeClicked = true
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
    
    func adBannerDidFetchAd(bannerAd: FlurryAdBanner!) {
        // Received Ad
        adBanner.displayAdInView(self.gameOverView, viewControllerForPresentation: self)
    }
    func adBannerDidRender(bannerAd: FlurryAdBanner!) {
        // For when your ad renders. Nice to check to make sure your ad is working
    }
}

