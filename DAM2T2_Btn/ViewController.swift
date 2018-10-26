//
//  ViewController.swift
//  DAM2T2_Btn
//
//  Created by Oscar Rossello on 09/10/2018.
//  Copyright © 2018 Oscar Rossello. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // BUTTONS
    @IBOutlet weak var btn_01: UIButton!
    @IBOutlet weak var btn_02: UIButton!
    @IBOutlet weak var btn_04: UIButton!
    @IBOutlet weak var btn_03: UIButton!
    @IBOutlet weak var btn_goAgane: UIButton!
    // BUTTONS ARRAY
    var buttons: [UIButton] = []
    // BUTTON TITLES ARRAY
    var buttonValues: [Int] = []
    // TIMER
    @IBOutlet weak var lbl_timer: UILabel!
    var timer = Timer()
    let maxTime: Int = 10
    var currTime: Int = 0 {
        didSet {
            lbl_timer.text = String(currTime)
        }
    }
    // SCORE
    @IBOutlet weak var lbl_score: UILabel!
    var score: Int = 0 {
        didSet {
            lbl_score.text = String(score)
        }
    }
    // GAME OVER
    @IBOutlet weak var lbl_gameOver: UILabel!
    var gameOverWin: String = "GJ YOU CAN COUNT :D"
    var gameOverLose: String = "GAME OVAH"
    
    @IBAction func btnClick(_ sender: UIButton) {
        // Check if button clicked has same value as first buttonValues value
        if sender.currentTitle == String(buttonValues[0]) {
            // RIGHT BUTTON PRESSED
            // Update score
            score += 1
            // Hide button + remove its value from values array
            sender.isHidden = true
            buttonValues.remove(at: 0)
            
            // If there's no more buttons left, show restart button
            if buttonValues.count == 0 {
                win()
            }
        }
    }
    
    // Hide restart button and show every other button
    @IBAction func restart(_ sender: UIButton) {
        initGame()
        sender.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize buttons array
        buttons = [btn_01, btn_02, btn_03, btn_04]
        initGame()
    }
    
    func initGame() {
        lbl_gameOver.isHidden = true
        
        // Set random numbers to buttons' title (-100 to 100) + add them to values array
        for button in buttons {
            button.isHidden = false
            
            let randomNumber = Int.random(in: -100...100)
            button.setTitle(String(randomNumber), for: .normal)
            
            buttonValues.append(randomNumber)
        }
        // Sort array ascendant
        buttonValues.sort()
        
        startTimer()
    }
    
    func startTimer() {
        currTime = maxTime
        lbl_timer.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if currTime > 0 {
            currTime -= 1
        } else {
            gameOver()
        }
    }
    
    func win() {
        // Reset + hide timer
        timer.invalidate()
        lbl_timer.isHidden = true
        
        // Show game over msg + restart button
        lbl_gameOver.text = gameOverWin
        lbl_gameOver.isHidden = false
        btn_goAgane.isHidden = false
    }
    
    func gameOver() {
        // Reset + hide timer
        timer.invalidate()
        lbl_timer.isHidden = true
        
        // Hide all buttons
        for button in buttons {
            button.isHidden = true
        }
        // Empty button values array
        buttonValues.removeAll()
        
        // Show game over msg + restart button
        lbl_gameOver.text = gameOverLose
        lbl_gameOver.isHidden = false
        btn_goAgane.isHidden = false
    }
}
