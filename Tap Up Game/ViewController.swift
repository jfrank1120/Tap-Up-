//
//  ViewController.swift
//  Tap Up Game
//
//  Created by  on 1/21/16.
//  Copyright © 2016 JFrank. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    @IBOutlet var gameTitleLabel: UILabel!
    @IBOutlet var optionsButtonOutlet: UIButton!
    @IBOutlet var playButtonOutlet: UIButton!
    var musicIsPlaying = false
    var greenSquare : UIView!
    var redSquare : UIView!
    var purpleSquare : UIView!
    var blueSquare : UIView!
    var squaresArray : [UIView] = []
    var gravityBehavior: UIGravityBehavior!
    var dynamicAnimator = UIDynamicAnimator()
    var menuAnimations : Bool!
    var colorChanges : Bool!
    var backGroundMusic : Bool!
    var soundEffects : Bool!
    var audioPlayer = AVAudioPlayer()
    var menuHasBeenAccessed = false
    var tilesOnScreen = 0
    func SetUpViewsDynamic() {
        // Blue Square
        let blueSquare = UIView(frame: CGRectMake(100, 100, 50, 50))
        blueSquare.backgroundColor = UIColor.cyanColor()
        view.addSubview(blueSquare)
        squaresArray.append(blueSquare)
        // Red Square
        let orangeSquare = UIView(frame: CGRectMake(100, 150, 50, 50))
        orangeSquare.backgroundColor = UIColor.orangeColor()
        view.addSubview(orangeSquare)
        squaresArray.append(orangeSquare)
        // Purple Square
        let yellowSquare =  UIView(frame: CGRectMake(150, 100, 50, 50))
        yellowSquare.backgroundColor = UIColor.yellowColor()
        view.addSubview(yellowSquare)
        squaresArray.append(yellowSquare)
        // Green Square
        let greenSquare =  UIView(frame: CGRectMake(150, 150, 50, 50))
        greenSquare.backgroundColor = UIColor.greenColor()
        view.addSubview(greenSquare)
        squaresArray.append(greenSquare)
        
        AddDynamicBehavior(squaresArray)
    }
    @IBAction func playButtonAction(sender: AnyObject) {
        if (musicIsPlaying == true)
        {
        audioPlayer.stop()
        }
    }
    func AddDynamicBehavior(Array : [UIView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
        dynamicItemBehavior.density = 1.5
        dynamicItemBehavior.friction = 0.0
        dynamicItemBehavior.resistance = 0.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        // Push Behavior
        let pushBehavior = UIPushBehavior(items: Array, mode: .Instantaneous)
        pushBehavior.magnitude = 0.5
        pushBehavior.pushDirection = CGVectorMake(1.0, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
        // Collision
        let collisionBehavior = UICollisionBehavior(items: Array)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Boundaries
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
        
        gravityBehavior = UIGravityBehavior(items: Array)
        gravityBehavior.magnitude = 0.0
        dynamicAnimator.addBehavior(gravityBehavior)
    }
    override func viewDidAppear(animated: Bool) {
        menuAnimations = true
        backGroundMusic = true
            if (menuAnimations == true) {
                if (tilesOnScreen > 0)
                {
                dynamicAnimator = UIDynamicAnimator(referenceView: view)
                SetUpViewsDynamic()
                tilesOnScreen++
                }
                else
                {
                    print("tiles already created on screen")
                }
            }
            if (backGroundMusic == true)
            {
                if (musicIsPlaying == false)
                {
                    let backgroundMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("8-punk-8-bit-music", ofType: "mp3")!)
                    audioPlayer = try! AVAudioPlayer(contentsOfURL: backgroundMusic)
                    audioPlayer.play()
                    musicIsPlaying = true
                }
            }
            else
            {
                print("Background music should be turned off")
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playButtonOutlet.layer.cornerRadius = 30
        optionsButtonOutlet.layer.cornerRadius = 20
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        SetUpViewsDynamic()
        self.view.bringSubviewToFront(playButtonOutlet)
        self.view.bringSubviewToFront(optionsButtonOutlet)
        self.view.bringSubviewToFront(gameTitleLabel)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "options"{
            let vc = segue.destinationViewController as! OptionsMenu
            vc.title = "OptionsMenu"
            vc.musicIsPlayng = musicIsPlaying
            vc.menuAccessedBool = menuHasBeenAccessed
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

