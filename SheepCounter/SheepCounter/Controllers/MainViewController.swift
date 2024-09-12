//
//  MainViewController.swift
//  SheepCounter
//
//  Created by Tiziano Casu on 10/09/2024.
//

import UIKit

class MainViewController :UIViewController{
    
    @IBAction func startBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCounter", sender: self)
    }
    
    
    @IBAction func creditsBtnPRessed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCredits", sender: self)

    }
    
    func pauseApp(){
        print("pause app pd")
    }
}
