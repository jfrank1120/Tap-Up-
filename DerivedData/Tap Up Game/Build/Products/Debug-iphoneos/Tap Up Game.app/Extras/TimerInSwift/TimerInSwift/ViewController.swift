
//
//  ViewController.swift
//  TimerInSwift
//
//  Created by Raul Pop on 5/23/15.
//  Copyright (c) 2015 Raul Pop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labelForBinaryCount: UILabel!
    var binaryCount = 0b0000
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start() {
        
        //timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateFrame", userInfo: nil, repeats: true)
    }
    
    func countUp() {
        
        binaryCount += 0b0001
        
        if (binaryCount == 0b10000) { binaryCount = 0b0000 }
        
        updateText()
        
    }
    
    @IBAction func reset() {
        
        timer.invalidate()
        
        binaryCount = 0b0000
        updateText()
    }
    
    func updateText() {
        
        var text = String(binaryCount, radix:2)
        for i in 0..<4 - text.characters.count {
            
            text = "0" + text;
        }
        
        labelForBinaryCount.text = text
    }
}

