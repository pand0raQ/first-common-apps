//
//  ViewController.swift
//  animation
//
//  Created by Halik Magomedov on 10/14/16.
//  Copyright © 2016 Haliks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func fadeIn(_ sender: AnyObject) {
        image.alpha = 0
        UIView.animate(withDuration: 5, animations: {
            self.image.alpha = 1
        })
    }
    @IBAction func slideIn(_ sender: AnyObject) {
        image.center = CGPoint(x: image.center.x - 500, y: image.center.y)
        UIView.animate(withDuration: 2) {
        self.image.center = CGPoint(x: self.image.center.x + 500, y: self.image.center.y)
        }
    }
    @IBAction func grow(_ sender: AnyObject) {
        image.frame = CGRect(x: 450, y: 450, width: 450, height: 450)
        UIView.animate(withDuration: 1 ) {
            self.image.frame = CGRect(x: 0, y: 0, width: 490, height: 490)
        }
    }
    @IBOutlet var buttonn: UIButton!
    @IBOutlet var image: UIImageView!
    var counter = 0
    var isAnimating = false
    
    var timer = Timer()
    func animate() {
        image.image = UIImage(named: "frame_\(counter)_delay-0.1s.gif")
        counter += 1
        if counter == 26 {
            counter = 0
            
        }
    }
    @IBAction func button(_ sender: AnyObject) {
        
        if isAnimating {
            timer.invalidate()
            buttonn.setTitle("Start Animation", for: [])
            isAnimating = false
            
        }else{
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
        buttonn.setTitle("Stop Animation", for: [])
            isAnimating = true
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
