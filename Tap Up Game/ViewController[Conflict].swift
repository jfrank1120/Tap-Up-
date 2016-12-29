//
//  ViewController.swift
//  Tap Up Game
//
//  Created by  on 1/21/16.
//  Copyright © 2016 JFrank. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    var dynamicAnimator = UIDynamicAnimator()
    var viewArray = [UIView]()
    var menuAnimations : Bool = true
    var colorChanges : Bool = true
    var backGroundMusic : Bool = true
    var soundEffects : Bool = true
    func SetUpViewsDynamic() {
        // Blue Square
        let blueSquare = UIView(frame: CGRectMake(100, 100, 50, 50))
        blueSquare.backgroundColor = UIColor.blueColor()
        view.addSubview(blueSquare)
        // Red Square
        let redSquare = UIView(frame: CGRectMake(200, 300, 50, 50))
        redSquare.backgroundColor = UIColor.redColor()
        view.addSubview(redSquare)
        // Purple Square
        let purpleSquare =  UIView(frame: CGRectMake(100, 300, 50, 50))
        purpleSquare.backgroundColor = UIColor.purpleColor()
        view.addSubview(purpleSquare)
        // Green Square
        let greenSquare =  UIView(frame: CGRectMake(250, 100, 50, 50))
        greenSquare.backgroundColor = UIColor.greenColor()
        view.addSubview(greenSquare)
        AddDynamicBehavior([blueSquare, redSquare, purpleSquare, greenSquare])
    }
    func SetUpViews () {
        // Blue Square
        let blueSquare = UIView(frame: CGRectMake(100, 100, 50, 50))
        blueSquare.backgroundColor = UIColor.blueColor()
        view.addSubview(blueSquare)
        // Red Square
        let redSquare = UIView(frame: CGRectMake(200, 300, 50, 50))
        redSquare.backgroundColor = UIColor.redColor()
        view.addSubview(redSquare)
        // Purple Square
        let purpleSquare =  UIView(frame: CGRectMake(100, 300, 50, 50))
        purpleSquare.backgroundColor = UIColor.purpleColor()
        view.addSubview(purpleSquare)
        // Green Square
        let greenSquare =  UIView(frame: CGRectMake(250, 100, 50, 50))
        greenSquare.backgroundColor = UIColor.greenColor()
        view.addSubview(greenSquare)
    }
    func AddDynamicBehavior(Array : [UIView]){
        let dynamicItemBehavior = UIDynamicItemBehavior(items: Array)
        dynamicItemBehavior.density = 0.5
        dynamicItemBehavior.friction = 0.0
        dynamicItemBehavior.resistance = 0.0
        dynamicItemBehavior.elasticity = 1.0
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        // Push Behavior
        let pushBehavior = UIPushBehavior(items: Array, mode: .Instantaneous)
        pushBehavior.magnitude = 1.0
        pushBehavior.pushDirection = CGVectorMake(0.5, 0.5)
        dynamicAnimator.addBehavior(pushBehavior)
        // Collision
        let collisionBehavior = UICollisionBehavior(items: Array)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Boundaries
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (menuAnimations == true) {
            SetUpViewsDynamic()
        }
        else {
            SetUpViews()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayGame"{
            let vc = segue.destinationViewController as! GameViewController
            vc.title = "GameViewController"
            vc.arrayOfViews = viewArray
        }
    }

}

