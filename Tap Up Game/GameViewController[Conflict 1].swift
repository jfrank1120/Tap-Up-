//
//  GameViewController.swift
//  Tap Up Game
//
//  Created by  on 1/21/16.
//  Copyright © 2016 JFrank. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, UICollisionBehaviorDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBAction func startButtonAction(sender: AnyObject) {
        startButtonOutlet.hidden = true
        delay(1.5)
            {
                self.StartGame()
        }
    }
    @IBOutlet var timerOutlet: UILabel!
    //var dynamicAnimator = UIDynamicAnimator(referenceView: gameViewController)
    var timesLooped = 0
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    var numberOfBallsOnScreen = 0
    var bottomViewBarrier : UIView!
    var dynamicAnimator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    var ballDynamicBehavior: UIDynamicItemBehavior!
    var collisionBehavior: UICollisionBehavior!
    var gravityBehavior: UIGravityBehavior!
    let singleTap: UITapGestureRecognizer = UITapGestureRecognizer()
    let throwingStrength = 100
    var screenWidth = (CGFloat)(UIScreen.mainScreen().bounds.width)
    var screenHeight = (CGFloat)(UIScreen.mainScreen().bounds.height)
    var ballArray : [UIView] = []
    var timerInt = 0
    var gameOver = false
    var ballCount = 0
    var numberOfTaps = 0
    var audioPlayer = AVAudioPlayer()
    func StartGame () {
        timerOutlet.text = "5"
        delay(0.5)
            {
                self.timerOutlet.text = "4"
                self.playSound("beep4", typeOfSound: "wav")
        }
        delay(1.0)
            {
                self.timerOutlet.text = "3"
                self.playSound("beep3", typeOfSound: "wav")
        }
        delay(1.5)
            {
                self.timerOutlet.text = "2"
                self.playSound("beep2", typeOfSound: "wav")
        }
        delay(2.0)
            {
                self.timerOutlet.text = "1"
                self.playSound("bepp1", typeOfSound: "wav")
        }
        delay(2.5)
            {
                self.timerOutlet.text = ""
        }
        delay(3.0)
            {
                self.playBackGroundMusic()
                self.createBalls(1)
                self.startTimer()
        }
    }
    func ResetGame () {
    }
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
    }
    func GameLost () {
        let alert = UIAlertController(title: "You Lost", message: "You Had \(numberOfTaps) taps", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: {action in self.ResetGame()}
        )
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    func startTimer () {
        print("timer has started")
        let aSelector : Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    func updateTime() {
        print("Time is updated")
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = Int(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        //calculate the seconds in elapsed time.
        let seconds = Int(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timerOutlet.text = "\(strMinutes):\(strSeconds)"
        
    }
    func playBackGroundMusic ()
    {
        let backgroundMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Daft Punk-Get Lucky", ofType: "mp3")!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: backgroundMusic)
        audioPlayer.play()
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    func addBallDynamicBehavior(Array : [UIView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
        dynamicItemBehavior.density = 0.75
        dynamicItemBehavior.friction = 1.5
        dynamicItemBehavior.resistance = 1.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        // Push Behavior
        let pushBehavior = UIPushBehavior(items: Array, mode: .Instantaneous)
        pushBehavior.magnitude = 50.0
        pushBehavior.pushDirection = CGVectorMake(0.0, 1.0)
        dynamicAnimator.addBehavior(pushBehavior)
        // Collision
        let collisionBehavior = UICollisionBehavior(items: Array)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Boundaries
        collisionBehavior.collisionDelegate = self
        collisionBehavior.addBoundaryWithIdentifier("Bottom", forPath: UIBezierPath())
        dynamicAnimator.addBehavior(collisionBehavior)
        
        gravityBehavior = UIGravityBehavior(items: Array)
        gravityBehavior.magnitude = 0.4
        dynamicAnimator.addBehavior(gravityBehavior)
    }
//    func bottomBarrierDynamicBehavior(Array : [UIView]){
//        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
//        dynamicItemBehavior.density = 500
//        dynamicItemBehavior.friction = 500
//        dynamicItemBehavior.resistance = 0.0
//        dynamicItemBehavior.elasticity = 1.0
//        dynamicAnimator.addBehavior(dynamicItemBehavior)
//        // Push Behavior
//        let pushBehavior = UIPushBehavior(items: Array, mode: .Instantaneous)
//        pushBehavior.magnitude = 0.25
//        pushBehavior.pushDirection = CGVectorMake(0.0, 1.0)
//        dynamicAnimator.addBehavior(pushBehavior)
//        // Collision
//        let collisionBehavior = UICollisionBehavior(items: Array)
//        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
//        collisionBehavior.collisionMode = .Boundaries
//        collisionBehavior.collisionDelegate = self
//        collisionBehavior.addBoundaryWithIdentifier("Bottom", forPath: UIBezierPath())
//        dynamicAnimator.addBehavior(collisionBehavior)
//    }
    func playSound (soundTitle : String, typeOfSound : String)
    {
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundTitle, ofType: typeOfSound)!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: sound)
        audioPlayer.play()

    }
    func createBalls (numberOfBalls : Int) {
        while (timesLooped != numberOfBalls)
        {
            let ball = UIView(frame: CGRectMake((screenWidth / 2),100, 50, 50))
            let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
            tap.delegate = self
            ball.addGestureRecognizer(tap)
            ball.backgroundColor = UIColor.blueColor()
            self.view.addSubview(ball)
            ballArray.append(ball)
            ball.layer.cornerRadius = 25
            addBallDynamicBehavior([ball])
            timesLooped++
            numberOfBallsOnScreen++
        }
        timesLooped = 0
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        numberOfTaps++
        let point = sender!.locationInView(self.view)
        var randomVectorX : CGFloat = 0.0
        var randomVectorY : CGFloat = 0.0
        for ball in ballArray
        {
            if (point.x <= ball.center.x)
            {
                randomVectorX = CGFloat((Double(arc4random_uniform(9)) - 10) / 10.0)
            }
            if (point.x > ball.center.x)
            {
                randomVectorX = CGFloat((Double(arc4random_uniform(9))) / 10.0)
            }
            randomVectorY = CGFloat(-1.0)
            pushBehavior = UIPushBehavior(items: [ball], mode: .Instantaneous)
            pushBehavior.magnitude = 50.0
            pushBehavior.pushDirection = CGVectorMake(randomVectorX, randomVectorY)
            pushBehavior.active = true
            dynamicAnimator.addBehavior(pushBehavior)
            collisionBehavior = UICollisionBehavior(items: ballArray)
            collisionBehavior.collisionMode = .Everything
            collisionBehavior.translatesReferenceBoundsIntoBoundary = true
            dynamicAnimator.addBehavior(collisionBehavior)
            collisionBehavior.collisionDelegate = self
        }
        if (numberOfTaps == 10)
        {
            createBalls(1)
        }
        if (numberOfTaps == 25)
        {
            createBalls(1)
        }
    }
    
    // Collison of ball with lower boundary
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        for ball in ballArray
        {
            if ((item1.isEqual(ball)) && (item2.isEqual(bottomViewBarrier)))
            {
                gameOver = true
                GameLost()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        bottomViewBarrier = UIView(frame: CGRectMake(0,590,CGFloat(screenWidth),10))
        //bottomBarrierDynamicBehavior([bottomBarrierView])
        //let dynamicAnimator = UIDynamicAnimator(referenceView: view)
        singleTap.addTarget(self, action: "collisionBehavior")
        
    }
}