//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Stefano De Cillis on 28/03/2017.
//  Copyright © 2017 Stefano De Cillis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //sound vars
    var btnSound: AVAudioPlayer!
    
    //math logic vars
    var runningNumber = ""
    enum Operation: String {
        case divide =  "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "Empty "
    }
    var currentOperation = Operation.empty
    var leftValueStr = ""
    var rightValueStr = ""
    var result = ""
    
    
    //sound file --> code (use URL / AVAudioPlayer ---> remember to import AVFoundation
    @IBOutlet weak var outputLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)

        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)   // try with file URL. When a statement asks a throws, we have to make a catch/error condition 
            btnSound.prepareToPlay()
        } catch let err as NSError {
         print(err.debugDescription)
        }
        outputLbl.text = "0"
        
    }
    
    
    //drag to storyboard buttons this function
    @IBAction func numberPressed (sender: UIButton)
    {
       
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
   
    @IBAction func onDividePressed (sender: AnyObject) {
        processOperation(operation: .divide)
    }
    
    @IBAction func onMultiplyPressed (sender: AnyObject) {
        processOperation(operation: .multiply)
    }
    
    @IBAction func onSubtractPressed (sender: AnyObject) {
        processOperation(operation: .subtract)
    }
    
    @IBAction func onAddPressed (sender: AnyObject) {
        processOperation(operation: .add)
    }
    
    @IBAction func onEqualPressed (sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed (sender: AnyObject) {
        currentOperation = Operation.empty
        leftValueStr = ""
        rightValueStr = ""
        result = ""
        runningNumber = ""
        outputLbl.text = "0"
    }
    
    //sound function
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation (operation: Operation){
       playSound()
        if Operation.empty != currentOperation {
            
            //A user selected an operatior, but then selected another operation without first entering a number
            if runningNumber != "" {
                rightValueStr = runningNumber
                runningNumber = ""
            
                if(currentOperation == Operation.multiply) {
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                } else if(currentOperation == Operation.divide) {
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                } else if(currentOperation == Operation.add) {
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                } else if(currentOperation == Operation.subtract) {
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }
                
                leftValueStr = result
                outputLbl.text = result
            }
            currentOperation = operation
    
    }
        else {
            //the first time an operator is pressed 
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    
    
}

    // ! --> To unwrap

}

