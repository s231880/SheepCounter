//
//  ViewController.swift
//  SheepCounter
//
//  Created by Tiziano Casu on 05/09/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var counter = 0
    @IBOutlet weak var TextField: UITextField!
    //Design solution not optimal, but due to time limit it will do 
    static var instance: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIScreen.main.brightness = CGFloat(0.1)
        TextField.isHidden = true
        initGesture()
        AnimationManager.shared.StartAnimation(view)
        AudioManager.shared.playBackgroundMusic()        
        
        ViewController.instance = self
    }
    
    func initGesture(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                longPressGesture.minimumPressDuration = 0 // Trigger immediately on touch
                view.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            switch gestureRecognizer.state {
            case .began:
                TextField.isHidden = false
            case .ended:
                TextField.isHidden = true
            default:
                break
            }
    }
    
    func updateCounter(_ val : Int){
        TextField.text = "\(val)"
    }
    
    func pauseApp(){
        TextField?.isHidden = true
    }
}

