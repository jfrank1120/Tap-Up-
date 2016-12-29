//
//  OptionsMenu.swift
//  Tap Up Game
//
//  Created by  on 1/21/16.
//  Copyright © 2016 JFrank. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
    }}
class OptionsMenu: UIViewController {
    var soundEffects = true
    var menuAnimations = true
    var colorChanges = true
    var backgroundMusic = true
    var musicIsPlayng : Bool!
    var menuAccessedBool : Bool!
    

    
    // Reset High Scores Button
    @IBAction func ResetHighScoresButton(sender: AnyObject) {
        print("High scores reset butotton has been pressed")
    }
    
    override func viewDidLoad() {
        menuAccessedBool = true
        if (menuAnimations == true)
        {
            
        }
        else
        {
           
        }
        if (backgroundMusic == true)
        {
            
        }
        else
        {
            
        }
        if (colorChanges == true)
        {
            
        }
        else
        {
            
        }
        if (soundEffects == true)
        {
           
        }
        else
        {
            
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToMenu"{
            let vc = segue.destinationViewController as! ViewController
            vc.title = "ViewController"
            vc.backGroundMusic = backgroundMusic
            vc.colorChanges = colorChanges
            vc.soundEffects = soundEffects
            vc.menuAnimations = menuAnimations
            vc.musicIsPlaying = musicIsPlayng
            vc.menuHasBeenAccessed = menuAccessedBool
            print("current state of options when sent :")
            print("background music = \(backgroundMusic)")
            print("color changes =  \(colorChanges) ")
            print("menu animations = \(menuAnimations)")
            print("music is playing = \(musicIsPlayng)")
            print("the menus has been accessed : \(menuAccessedBool)")
        }
    }
}
