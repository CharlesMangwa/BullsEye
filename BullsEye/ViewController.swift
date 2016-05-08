//
//  ViewController.swift
//  BullsEye
//
//  Created by Charles MANGWA on 20/04/2016.
//  Copyright © 2016 Charles MANGWA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlited")
        slider.setThumbImage(thumbImageHighlited, forState: .Highlighted)

        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfectly nailed it👌!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1{
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good though!"
        } else if 20 < difference && difference < 40 {
            title = "You suck…"
            points -= 15
        } else {
            title = "You suck…"
//            points -= 25
        }
        
        score += points
        
        let message = "You scored \(points) points!"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Cool!",
                                   style: .Default,
                                   handler: { action in
                                        self.startNewRound()
                                        self.updateLabels()
                                   })
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
}

