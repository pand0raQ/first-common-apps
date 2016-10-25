//
//  ViewController.swift
//  whats the weather
//
//  Created by Halik Magomedov on 10/11/16.
//  Copyright © 2016 Haliks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var field: UITextField!
    @IBOutlet var result: UILabel!
    @IBAction func getWeather(_ sender: AnyObject) {
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + field.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            if error != nil {
                print(error)
            }
            else{
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        if contentArray.count > 1 {
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            if newContentArray.count > 1 {
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                print(message)
                            }
                            
                            
                            
                        }

                    }
                }
            }
            
            if message == "" {
                message = "Couldn't be found, what a hell are you requesting BLEAT?"
            }
            
            DispatchQueue.main.sync(execute: {
                self.result.text = message
                
            })
            
            
        }
        
        task.resume()

    }
        else{
            result.text = "Couldn't be found, what a hell are you requesting BLEAT?"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.{
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
