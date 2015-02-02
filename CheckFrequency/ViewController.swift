//
//  ViewController.swift
//  CheckFrequency
//
//  Created by dumbfly on 11/01/15.
//  Copyright (c) 2015 dumbfly. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var counter = 0
    var digitValues: [String] = ["0","1","2","3","4","5","6","7","8","9"]
    
    //var sequence = [UInt32](count: 6, repeatedValue: 0)
    var oldSequenceStr = ""
    var newSequenceStr = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //generateSequence()
        answer.text = ""
        result.text = ""
        delay(3){
            self.generateSequence()
        }
    }
    
    func generateSequence(){
        
        answer.text = ""
        result.text = ""
        counter = 0

        oldSequenceStr = newSequenceStr
        newSequenceStr = ""
        for var index = 0; index < 6; ++index {
            var valIndex = arc4random_uniform(10)
            //sequence[index] = valIndex
            playSample(digitValues[Int(valIndex)])
            newSequenceStr = newSequenceStr + " " + digitValues[Int(valIndex)]
        }
        //println(sequence)
    }
    
    func delayTillPlaying(){
        var i = 0
        do {
            i++
        } while(audioPlayer.playing)
        //println(i)
    }
    
    func playSample(name: String){
        var path = NSBundle.mainBundle().pathForResource(name, ofType: "mp3")!
        var audioPath = NSURL(fileURLWithPath: path)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        delayTillPlaying()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func buttonHandler(name:String)
    {
        counter++
        answer.text = answer.text! + name + " "
        
        if (counter >= 6) {
            result.text = newSequenceStr
            delay(3) {
                self.generateSequence()
            }
            //answer.text = ""
            //counter = 0

        }

    }
    
    
    @IBAction func pressZero(sender: AnyObject) {
        buttonHandler("0")
    }
    @IBAction func pressNine(sender: AnyObject) {
        buttonHandler("9")
    }
    @IBAction func pressEight(sender: AnyObject) {
        buttonHandler("8")
    }
    @IBAction func pressSeven(sender: AnyObject) {
        buttonHandler("7")
    }
    @IBAction func pressSix(sender: AnyObject) {
        buttonHandler("6")
    }
    @IBAction func pressFive(sender: AnyObject) {
        buttonHandler("5")
    }
    @IBAction func pressFour(sender: AnyObject) {
        buttonHandler("4")
    }
    @IBAction func pressThree(sender: AnyObject) {
        buttonHandler("3")
    }
    @IBAction func pressTwo(sender: AnyObject) {
        buttonHandler("2")
    }
    @IBAction func pressOne(sender: AnyObject) {
        buttonHandler("1")
        
    }


}

