//
//  GameViewController.swift
//  Tap Up Game
//
//  Created by  on 1/21/16.
//  Copyright © 2016 JFrank. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollisionBehaviorDelegate {
    var dynamicAnimator = UIDynamicAnimator()
    var arrayOfViews = [UIView]()
    var location = CGPoint(x: 0, y: 0)
    
    overrride func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        var touch : UITouch! = touches.anyObject() as! UITouch
        location = touch.locationInView(self.view)
        createdView.center = location
    }
    @IBOutlet weak var vaultBoyImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        SetUpViews()
    }
    func SetUpImages () {
        let imageName = "vaultBoy"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 100, y: 100, width: 250, height: 250)
        view.addSubview(imageView)
        AddDynamicBehavior([imageView])
    }
    func AddDynamicBehavior(Array : [UIImageView]){
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
        let collisionBehavior = UICollisionBehavior(items: Array)(
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .Boundaries
        collisionBehavior.collisionDelegate = self
        dynamicAnimator.addBehavior(collisionBehavior)
    }
    
}