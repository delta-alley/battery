//
//  ViewController.swift
//  Battery
//
//  Created by Bas Broek on 06/04/16.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private let heightTotal = 600.0
  @IBOutlet var heightConstraint: NSLayoutConstraint! {
    didSet {
      heightConstraint.constant = 0.0
    }
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func walkIn(sender: AnyObject) {
    let walk = Walk(speed: 5.0, walkingIn: true)
    
    walk.start { batteryLevel in
      self.heightConstraint.constant = 600.0 * (CGFloat(batteryLevel) / 100.0)
    }
  }
  
  @IBAction func walkOut(sender: AnyObject) {
    let walk = Walk(speed: 5.0, walkingIn: false)
    
    walk.start { batteryLevel in
      self.heightConstraint.constant = 600.0 * (CGFloat(batteryLevel) / 100.0)
    }
  }
  
  @IBAction func clear(sender: AnyObject) {
    heightConstraint.constant = 0.0
  }
}