//
//  ViewController.swift
//  Calculator
//
//  Created by jack on 6/26/15.
//
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = brain.clear()
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit != "." || display.text!.rangeOfString(".") == nil {
                display.text = display.text! + digit
            }
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                // TODO: displayValue should accept an optional
                displayValue = 0
            }
        }
    }
    
    @IBAction func pi(sender: UIButton) {
        enter()
        brain.pushOperand(M_PI)
        display.text = sender.currentTitle!
        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            // TODO: displayValue should accept an optional
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            if display.text! == "π" {
                return M_PI
            } else {
                return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}