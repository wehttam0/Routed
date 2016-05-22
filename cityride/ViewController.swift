//
//  ViewController.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var zipcodeField: UITextField!

    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    let cgRectFrame = CGRectMake(0, zipcodeField.bounds.maxY-1, zipcodeField.bounds.width, 1)
        
        goButton.layer.cornerRadius = 5;
        
    var subView = UIView.init(frame: cgRectFrame)
        
    subView.backgroundColor = UIColor.lightGrayColor()
        
        //zipcodeField.addSubview(subView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "randomsegue"
        {
            if let destinationVC = segue.destinationViewController as? RideShareChoices {
                destinationVC.destintion = destination.text!
            }
        }
    }

}

