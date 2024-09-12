//
//  AnimationController.swift
//  SheepCounter
//
//  Created by Tiziano Casu on 11/09/2024.
//

import Foundation
import UIKit

class AnimationManager{
    static let shared = AnimationManager()
    var imageView : UIImageView?
    var counter = 0
    var timer : Timer?
    var view : UIView?
    var animationPauseTime : CFTimeInterval = 0
    var animationStartTime : CFTimeInterval = 0
    var animationPaused : Bool = false
    
    
    private init() {}
    
    func StartInfiniteLoop(){
        timer = Timer.scheduledTimer(withTimeInterval: 2.6, repeats: true) { timer in self.AnimateImage()}
    }
    
    func StartAnimation(_ view : UIView){
        if imageView == nil {
            let image = UIImage(named : "NewJumpingSheep")
            imageView = UIImageView(image: image)
            imageView?.frame = CGRect(x: 493, y: 284, width: 200, height: 200)
            if let imageView = imageView {
                view.addSubview(imageView)
            }
        }
        self.view = view
        StartInfiniteLoop()
    }
    
    func AnimateImage(){
        let path = UIBezierPath()
        //Start point
        path.move(to: CGPoint(x: 493, y: 284))
        //End point
        path.addQuadCurve(to: CGPoint(x: 200, y: 700), controlPoint: CGPoint(x: 300, y: 350))
        path.addQuadCurve(to: CGPoint(x: -50, y: 700), controlPoint: CGPoint(x: 100, y: 200))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 2.5
        animation.path = path.cgPath
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        
        // Add the animation to the imageView
        imageView!.layer.add(animation, forKey: "arcAnimation")
        animationStartTime = CACurrentMediaTime()
        counter += 1
        ViewController.instance?.updateCounter(counter)
    }
    
    func pauseApp(){
        animationPaused = true
        timer?.invalidate()
        animationPauseTime = CACurrentMediaTime()
        view?.layer.pauseAnimation()
    }
    
    func resumeApp(){
        if animationPaused == true {
            view?.layer.resumeAnimation()
            animationPaused = false
            let interval = Double(String(format: "%.1f",animationPauseTime - animationStartTime))!
            timer = Timer.scheduledTimer(withTimeInterval: 2.6 - interval, repeats: false) { timer in self.AnimateImage()
                self.StartInfiniteLoop()
            }
        }
    }
}

extension CALayer{
    func pauseAnimation(){
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }

    func resumeAnimation() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
       
    }
}
