//
//  ViewController.swift
//  Calculator
//
//  Created by Sangjin Shin on 6/26/16.
//  Copyright © 2016 Sangjin Shin. All rights reserved.
//

import UIKit

enum modes {
    case NOT_SET
    case ADDITION
    case SUBTRACTION
    case MULTIPLICATION
    case DIVISION
}

class ViewController: UIViewController {
    
    // Instance vars
    var labelString:String = "0"
    var currentMode:modes = modes.NOT_SET
    var savedNum:Double = 0.0
    var lastButtonWasMode:Bool = false
    
    // Result label
    @IBOutlet weak var label: UILabel!
    
    // Number keys
    @IBAction func tapped0(sender: AnyObject) {tappedNumber(0)}
    @IBAction func tapped1(sender: AnyObject) {tappedNumber(1)}
    @IBAction func tapped2(sender: AnyObject) {tappedNumber(2)}
    @IBAction func tapped3(sender: AnyObject) {tappedNumber(3)}
    @IBAction func tapped4(sender: AnyObject) {tappedNumber(4)}
    @IBAction func tapped5(sender: AnyObject) {tappedNumber(5)}
    @IBAction func tapped6(sender: AnyObject) {tappedNumber(6)}
    @IBAction func tapped7(sender: AnyObject) {tappedNumber(7)}
    @IBAction func tapped8(sender: AnyObject) {tappedNumber(8)}
    @IBAction func tapped9(sender: AnyObject) {tappedNumber(9)}
    
    // Function keys
    @IBAction func tappedPlus(sender: AnyObject) {
        changeMode(modes.ADDITION)
    }
    @IBAction func tappedMinus(sender: AnyObject) {
        changeMode(modes.SUBTRACTION)
    }
    @IBAction func tappedMultiply(sender: AnyObject) {
        changeMode(modes.MULTIPLICATION)
    }
    @IBAction func tappedDivide(sender: AnyObject) {
        changeMode(modes.DIVISION)
    }
    @IBAction func tappedEquals(sender: AnyObject) {
        guard let num:Double = Double(labelString) else {
            return
        }
        if currentMode == modes.NOT_SET || lastButtonWasMode {
            return
        }
        if currentMode == modes.ADDITION {
            savedNum += num
        } else if currentMode == modes.SUBTRACTION {
            savedNum -= num
        } else if currentMode == modes.MULTIPLICATION {
            savedNum *= num
        } else if currentMode == modes.DIVISION {
            savedNum /= num
        }
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    @IBAction func tappedClear(sender: AnyObject) {
        labelString = "0"
        label.text = "0"
        currentMode = modes.NOT_SET
        savedNum = 0;
        lastButtonWasMode = false;
    }
    
    // Methods
    func tappedNumber(num:Int) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.stringByAppendingString("\(num)")
        updateText()
    }
    
    func updateText() {
        guard let labelDouble:Double = Double(labelString) else {
            label.text = "Double conversion failed"
            return
        }
        if currentMode == modes.NOT_SET {
            savedNum = labelDouble
        }
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let num:NSNumber = NSNumber(double: labelDouble)
        label.text = formatter.stringFromNumber(num)
    }
    
    func changeMode(newMode:modes) {
        if savedNum == 0 {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}

