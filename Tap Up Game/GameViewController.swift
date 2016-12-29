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
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var backButtonAtStart: UIButton!
    var powerUpNumbersCreated = 0
    @IBAction func startButtonAction(sender: AnyObject) {
        startButtonOutlet.hidden = true
        backButtonAtStart.hidden = true
        delay(1.5)
            {
                self.StartGame()
        }
    }
    @IBOutlet weak var timerOutlet: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    //var dynamicAnimator = UIDynamicAnimator(referenceView: gameViewController)
    var powerUp : UIImageView!
    var gravityFloat : CGFloat = 0.4
    var powerUpArray : [UIImageView] = []
    var randomNumberArray : [Int] = []
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
    var numberOfPowerUpsOnScreen = 0
    var timerInt = 0
    var powerUp1Type = -1
    var powerUp2Type = -1
    var powerUp3Type = -1
    var gameOver = false
    var ballCount = 0
    var numberOfTaps = 0
    var barrierLives = 1
    var audioPlayer = AVAudioPlayer()
    var backgroundMusicPlayer = AVAudioPlayer()
    func StartGame () {
        countdownLabel.text = "5"
        delay(0.5)
            {
                self.countdownLabel.text = "4"
                self.playSound("beep4", typeOfSound: "wav")
        }
        delay(1.0)
            {
                self.countdownLabel.text = "3"
                self.playSound("beep3", typeOfSound: "wav")
        }
        delay(1.5)
            {
                self.countdownLabel.text = "2"
                self.playSound("beep2", typeOfSound: "wav")
        }
        delay(2.0)
            {
                self.countdownLabel.text = "1"
                self.playSound("bepp1", typeOfSound: "wav")
        }
        delay(2.5)
            {
                self.countdownLabel.text = ""
        }
        delay(3.0)
            {
                self.playBackGroundMusic()
                self.createBalls(1)
                self.startTimer()
        }
    }
    func ResetGame () {
        ballArray.removeAll()
        powerUpArray.removeAll()
        for ball in ballArray
        {
            ball.removeFromSuperview()
            ball.backgroundColor = UIColor.whiteColor()
        }
        startButtonOutlet.hidden = false
        backButtonAtStart.hidden = false
        gameOver = false
    }
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
    }
    func GameLost () {
        let alert = UIAlertController(title: "YOU LOST", message: "You Had \(numberOfTaps) taps", preferredStyle: .Alert)
        let mainMenuAction = UIAlertAction(title: "Main Menu", style: .Default, handler:  {action in self.performSegueWithIdentifier("backToMenu", sender: self) })
        let retryAction = UIAlertAction(title: "Retry", style: .Default, handler: {action in self.ResetGame()})
        alert.addAction(mainMenuAction)
        alert.addAction(retryAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBAction func OnViewTappped(sender: UITapGestureRecognizer) {
       
    }
    func startTimer () {
        print("timer has started")
        let aSelector : Selector = "updateTime"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    func updateTime() {
        //print("Time is updated")
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
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
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOfURL: backgroundMusic)
        backgroundMusicPlayer.play()
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
        pushBehavior.magnitude = 0.05
        pushBehavior.pushDirection = CGVectorMake(0.0, -1.0)
        dynamicAnimator.addBehavior(pushBehavior)
        // Collision
        collisionBehavior = UICollisionBehavior(items: Array + [bottomViewBarrier])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        collisionBehavior.addBoundaryWithIdentifier("Bottom", forPath: UIBezierPath())
        dynamicAnimator.addBehavior(collisionBehavior)
        
        gravityBehavior = UIGravityBehavior(items: Array)
        gravityBehavior.magnitude = gravityFloat
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    func powerUpDynamicBehavior(Array : [UIImageView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
        dynamicItemBehavior.density = 0.0
        dynamicItemBehavior.friction = 1.5
        dynamicItemBehavior.resistance = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        // Push Behavior
        // Collision
        collisionBehavior = UICollisionBehavior(items: [bottomViewBarrier] + ballArray)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    func addBarrierDynamicBehavior(Array : [UIView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
        dynamicItemBehavior.density = 100.0
        dynamicItemBehavior.friction = 1.5
        dynamicItemBehavior.resistance = 1.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        // Push Behavior
        // Collision
        collisionBehavior = UICollisionBehavior(items: [bottomViewBarrier] + ballArray)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Everything
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }
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
            collisionBehavior.addItem(ball)
            timesLooped++
            numberOfBallsOnScreen++
        }
        timesLooped = 0
    }
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        numberOfTaps++
        print(" tap #\(numberOfTaps)")
        playSound("Good Jump", typeOfSound: "wav")
        let point = sender!.locationInView(self.view)
        var randomVectorX : CGFloat = 0.0
        var randomVectorY : CGFloat = 0.0
        for ball in ballArray
        {
            if (point.x > ball.center.x)
            {
                randomVectorX = CGFloat((Double(arc4random_uniform(7)) - 10) / 10.0)
            }
            if (point.x <= ball.center.x)
            {
                randomVectorX = CGFloat((Double(arc4random_uniform(7))) / 10.0)
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
            collisionBehavior.addItem(ball)
        }
//        if (numberOfTaps == 7)
//        {
//            let backgroundMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Epic Sax Guy8-bit", ofType: "mp3")!)
//            backgroundMusicPlayer = try! AVAudioPlayer(contentsOfURL: backgroundMusic)
//            backgroundMusicPlayer.play()
//            let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
//            label.center = CGPointMake(160, 284)
//            label.textAlignment = NSTextAlignment.Center
//            label.text = "FeelsBadMan"
//            let label2 = UILabel(frame: CGRectMake(0, 0, 200, 21))
//            label.center = CGPointMake(screenWidth, 150)
//            label.textAlignment = NSTextAlignment.Center
//            label.text = "( ͡° ͜ʖ ͡°)"
//            self.view.addSubview(label)
//            self.view.addSubview(label2)
//        }
        if (numberOfTaps > 5)
        {
            checkForPowerUp()
        }
        if (numberOfTaps > 30)
        {
            gravityFloat = 0.8
            gravityBehavior.magnitude = 0.8
        }
        if (numberOfTaps > 50)
        {
            gravityFloat = 1.0
            gravityBehavior.magnitude = 1.0
        }
        if (numberOfTaps > 75)
        {
            gravityFloat = 1.35
            gravityBehavior.magnitude = 1.35
        }
        if (numberOfTaps > 100)
        {
            gravityFloat = 1.55
            gravityBehavior.magnitude = 1.55
        }
    }
    func slowMoPowerUp (powerUp : UIImageView)
    {
        
    }
    func lowGravityPowerUp (powerUp : UIImageView)
    {
        gravityBehavior.magnitude = 0.2
        delay(15.0)
            {
                self.gravityBehavior.magnitude = self.gravityFloat
        }
    }
    func extraLifePowerUp (powerUp : UIImageView)
    {
        barrierLives++
    }
    func growthPowerUp (powerUp : UIImageView) {
    }
    func memePowerUp (powerUp : UIImageView) {
        let backgroundMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Epic Sax Guy8-bit", ofType: "mp3")!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOfURL: backgroundMusic)
        backgroundMusicPlayer.play()
        let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "FeelsBadMan"
        let label2 = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(screenWidth, 150)
        label.textAlignment = NSTextAlignment.Center
        label.text = "( ͡° ͜ʖ ͡°)"
        self.view.addSubview(label)
        self.view.addSubview(label2)
        delay(15.0)
            {
                self.playBackGroundMusic()
                label.hidden = true
                label2.hidden = true
        }
    }
    func createPowerUp ()
    {
        print("PowerUp Created")
        numberOfPowerUpsOnScreen++
        let int32ScrnHeight : UInt32 = UInt32(screenHeight)
        let int32ScrnWidth : UInt32 = UInt32(screenWidth)
        let randomXValue = (CGFloat(arc4random_uniform(int32ScrnWidth - UInt32(20)) + 20))
        let randomYValue = (CGFloat(arc4random_uniform(int32ScrnHeight - UInt32(20)) + 20))
        let powerUp = UIImageView(frame: CGRectMake(randomXValue,randomYValue, 40, 40))
        powerUpArray.append(powerUp)
        powerUp.userInteractionEnabled = true
        collisionBehavior.addItem(powerUp)
        powerUp.tag = Int(arc4random_uniform(4))
        switch powerUp.tag
        {
        case (0):
            print("second life powerup has appeared")
            powerUp.image = UIImage(named: "extraLifeImage")
            print("background image created")
            break
        case (1):
            print("slow mo powerUp has appeared")
            powerUp.image = UIImage(named: "slowDownImage")
            print("background image created")
            break
        case (2):
            print("gravity decrease powerup has appeared")
            powerUp.image = UIImage(named: "lowGravity")
            print("background image created")
            break
        case (3):
            print("ball size increase has appeared")
            powerUp.image = UIImage(named: "growthPowerUp")
            print("background image created")
            break
        case (4):
            print("Epic memes power up has appeared")
            powerUp.image = UIImage(named: "fedoraPowerUp")
            print("background image created")
        default:
            errorMessage()
            break
        }
        self.view.addSubview(powerUp)
    }
    func errorMessage ()
    {
        let alert = UIAlertController(title: "ERROR - 305", message: "An Error Has Occurred, Please restart", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    func checkForPowerUp ()
    {
        let randomChance = (Int(arc4random_uniform(3)))
        if (randomChance == 1)
        {
            let randomNumber = (Int(arc4random_uniform(20)) + numberOfTaps)
            print("rand = \(randomNumber)")
            randomNumberArray.append(randomNumber)
        }
        for number in randomNumberArray
        {
            if (numberOfTaps == number && numberOfPowerUpsOnScreen <= 3)
            {
                powerUpNumbersCreated++
                if (powerUpNumbersCreated <= 3)
                {
                createPowerUp()
                }
                else
                {
                    print("Too many numbers already created, wait until next is hit")
                }
            }
        }
    }
    // Collison of ball with lower boundary
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        for ball in ballArray
        {
            if ((item1.isEqual(ball)) && (item2.isEqual(bottomViewBarrier)))
            {
                backgroundMusicPlayer.stop()
                print("Game Lost")
                gameOver = true
                GameLost()
            }
            if ((item1.isEqual(bottomViewBarrier)) && (item2.isEqual(ball)))
            {
                backgroundMusicPlayer.stop()
                print("Game Lost")
                gameOver = true
                GameLost()
            }
            for hitPowerUp in powerUpArray
            {
                if (item1.isEqual(ball)) && (item2.isEqual(hitPowerUp))
                {
                    barrierLives--
                    if (barrierLives == 0)
                    {
                    if (hitPowerUp.tag == 0)
                    {
                        slowMoPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 1)
                    {
                        lowGravityPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 2)
                    {
                        extraLifePowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 3)
                    {
                        growthPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 4)
                    {
                        memePowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    }
                }
                if (item1.isEqual(hitPowerUp)) && (item2.isEqual(ball))
                {
                    barrierLives--
                    if (barrierLives == 0)
                    {
                    if (hitPowerUp.tag == 0)
                    {
                        slowMoPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 1)
                    {
                        lowGravityPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 2)
                    {
                        extraLifePowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 3)
                    {
                        growthPowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    if (hitPowerUp.tag == 4)
                    {
                        memePowerUp(hitPowerUp)
                        hitPowerUp.removeFromSuperview()
                        powerUpArray.removeAtIndex(powerUpArray.indexOf(hitPowerUp)!)
                    }
                    }
                }
                
            }
        }
    }
    func createBottomViewBarrier () {
        bottomViewBarrier = UIView(frame: CGRectMake(0,CGFloat(screenHeight - 10),CGFloat(screenWidth),10))
        self.view.addSubview(bottomViewBarrier)
        addBarrierDynamicBehavior([bottomViewBarrier])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("New Verison")
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        createBottomViewBarrier()
    }
}