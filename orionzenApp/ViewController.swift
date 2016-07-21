//
//  ViewController.swift
//  orionzenApp
//
//  Created by Eshan trivedi on 11/07/16.
//  Copyright © 2016 ET. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   var toggle = 1

    @IBOutlet var creditLabel: UILabel!
    
    @IBOutlet var timerCount: UILabel!
    
    @IBOutlet var countDown: UILabel!
    

   
    @IBOutlet var waterLevel: UIImageView!
   
   
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var widthConstraint: NSLayoutConstraint!

    
  
    
    var credit = 0
    
    var mins = 0
    var sec = 0
    
    var timer = NSTimer()
    var countDownn = NSTimer()
    
    var time = 0
    var downTime = 60
    var waterHeight = 300
    
    
    
   
    
    func increaseTimer()
    {
        time++
        
        timerCount.text = "\(time)s"
        
        if time < 60
        {timerCount.text = "\(time)"}
        else
        {  mins = Int(time/60)
            sec = time%60
            timerCount.text = "\(mins)m\(sec)s"}
        
    
      
        
        

        
        
      UIView.animateWithDuration(60, delay: 0, options: [.Repeat], animations: { () -> Void in
        self.waterLevel.bounds = CGRectMake(330, 241, 241, 330)
        self.heightConstraint.constant = CGRectGetHeight(self.waterLevel.bounds)
        self.widthConstraint.constant = CGRectGetWidth(self.waterLevel.bounds)
        self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        
    }

    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    
    
    
    
    
    func decreaseTime()
    {
        
        downTime--
        countDown.text = "\(downTime)"
        
        if downTime == 0
        {
            downTime = 60
            let credit = Int(time/60) * 10
            creditLabel.text = "\(credit)"
        }
        }
    

            
       
        

        
        
        
        
        

    
    func willEnterForeground() {
        print("foreground")
        
        let credit = Int(time/60) * 10
        creditLabel.text = "\(credit)"
        if toggle == 0
        { timer.invalidate()
            countDownn.invalidate()
        toggle = 1
            let layer = waterLevel.layer
            pauseLayer(layer)
            
        }
        
    }

    
    func willEnterBackground() {
        
        if toggle == 1
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
            
            countDownn = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTime"), userInfo: nil, repeats: true)
        toggle = 0
            let layer = waterLevel.layer
            resumeLayer(layer)
        }
        
        print("background")
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
       if self.toggle==1
       {
         timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
        
        countDownn = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("decreaseTime"), userInfo: nil, repeats: true)
        self.toggle = 0
        
        }
        
      
        
            
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("willEnterForeground"), name: UIApplicationWillEnterForegroundNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("willEnterBackground"), name: UIApplicationWillResignActiveNotification, object: nil)
        
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

