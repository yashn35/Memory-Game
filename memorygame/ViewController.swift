//
//  ViewController.swift
//  memorygame
//
//  Created by AMIT NARAYAN on 6/14/16.
//  Copyright © 2016 NarayanProduction. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var sound = URL(fileURLWithPath: Bundle.main.path(forResource: "button", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var blue: UIButton!
    
    @IBOutlet weak var yellow: UIButton!
    
    @IBOutlet weak var red: UIButton!
    
    @IBOutlet weak var green: UIButton!
    
    
    @IBOutlet weak var label: UILabel!
    
    var pattern: [String] = []
    var current = 0
    var canClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        choose("nothing")
        addRandomColor()
        showPattern()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        audioPlayer = try! AVAudioPlayer(contentsOf: sound)
       
     
    
    }
    
    func addRandomColor() {
        
       let random = arc4random_uniform(4)
        if random == 0 {
            pattern.append("red")
        }
        if random == 1 {
            pattern.append("green")
      
        
        }
        if random == 2 {
            
            pattern.append("yellow")
        }
        if random == 3 {
            
            pattern.append("blue")
            
        }
    
    }
    
    func showPattern() {
        label.text = "Remember the pattern"
        canClick = false
        // Set the text of the label to "get ready"
        for i in 0 ... pattern.count - 1 {
            delay (1.0 * Double(i)) {
                
                self.choose(self.pattern[i])
            }
          
            delay (1.0 * Double(i) + 0.6) {
                self.choose("nothing")
          
            
            }
            //Prompt them to repeat
            delay(1.0 * Double(pattern.count)) {
                self.label.text = "Repeat the pattern"
                self.canClick = true
                //Set the text of the label to "Now you repeat it"
            }
        
        }
        
    }
    
    
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func choose(_ button: String) {
        // Deactivate all the buttons
        blue.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5)
        green.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        red.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        yellow.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
        
        // Activate the chosen button
        if button == "blue" {
            blue.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        }
        if button == "red" {
            red.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        if button == "green" {
            green.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }
        if button == "yellow" {
            yellow.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    func selected(_ button: String) {
        if canClick {
            choose(button)
            if pattern[current] == button {
                current = current + 1
                if current == pattern.count {
                    addRandomColor()
                    current = 0
                    showPattern()
                }
            }
            else {
                label.text = "Pattern is Wrong, Try Again"
                current = 0
            }
        }
    }

    
     @IBAction func greenClicked(_ sender: AnyObject) {
        selected("green")
        // audioPlayer.play()

            
        


        
    }

    @IBAction func redClicked(_ sender: AnyObject) {
       selected("red")
       // audioPlayer.play()

    }
    @IBAction func yellowClicked(_ sender: AnyObject) {
       selected("yellow")
        // audioPlayer.play()

    }
    @IBAction func blueClicked(_ sender: AnyObject) {
         selected("blue")
         // audioPlayer.play()

    
    }


}
