//
//  ViewController.swift
//  BullsEye
//
//  Created by Josh Nagel on 1/2/15.
//  Copyright (c) 2015 jnagel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetBullsEye: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var round: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    private var target: Int!
    
    private var currentVal = 50
    
    private var currentScore = 0
    
    private var roundVal = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newTargetVal()
        self.currentVal = lroundf(slider.value)
    }
    
    func newTargetVal() {
        self.target = 1 + Int(arc4random_uniform(100))
        self.targetBullsEye.text = String(target)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderChanged(slider: UISlider) {
        currentVal = lroundf(slider.value)
    }

    @IBAction func startOverPressed(sender: UIButton) {
        self.currentScore = 0
        self.currentVal = 50
        self.roundVal = 1
        newTargetVal()
        slider.value = Float(currentVal)
        score.text = String(self.currentScore)
        round.text = String(self.roundVal)
    }
    
    @IBAction func hitMePressed(sender: UIButton) {
        var pointsAwarded = pointsAwardedCalc()
        var alert = UIAlertController(title: "Missed!", message: "The value selected was \(currentVal). \n \(pointsAwarded) points are rewarded", preferredStyle: .Alert)
        if pointsAwarded == 100 {
            alert = UIAlertController(title: "Bull's Eye!", message: "100 points are awarded \(pointsAwarded)", preferredStyle: .Alert)
        }
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        updateScore(pointsAwarded)
        newTargetVal()
        
    }
    
    func updateScore(pointsAwarded : Int) {
        self.currentScore = self.currentScore + pointsAwarded
        score.text = String(self.currentScore)
    }
    
    func pointsAwardedCalc() -> Int {
        var difference: Int
        if self.currentVal > self.target {
            difference = self.currentVal - self.target
        } else {
            difference = self.target - self.currentVal
        }
        return 100 - difference
    }
    
    @IBAction func infoPressed(sender: UIButton) {
    }
}

