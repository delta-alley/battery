//
//  Walk.swift
//  Battery
//
//  Created by Bas Broek on 06/04/16.
//  Copyright © 2016 Bas Broek. All rights reserved.
//

import UIKit

func after(delay: CGFloat, closure: Void -> Void) {
  dispatch_after(
    dispatch_time(
      DISPATCH_TIME_NOW,
      Int64(delay * CGFloat(NSEC_PER_SEC))
    ),
    dispatch_get_main_queue(), closure)
}

struct Walk {
  var speed: Double // km / h
  var walkingIn: Bool
  let hallwayLength = 60 // meter
  
  var time: Double {
    return Double(hallwayLength) / speed
  }
  
  func start(completionHandler: (batteryLevel: Double) -> Void) {
    let fullBattery = 100.0
    let incrementAmount = 100.0 / time
    let incrementCount = Int(100.0 / incrementAmount)
    
    for incrementation in 0...incrementCount {
      after(CGFloat(incrementation)) {
        let value = incrementAmount * Double(incrementation)
        completionHandler(batteryLevel: (self.walkingIn) ? value : fullBattery - value)
      }
    }
    
    if incrementAmount * Double(incrementCount) != fullBattery {
      // FIXME: this should fire at the correct timing, instead of just seeing this as the next value in the linear graph.
      after(CGFloat(incrementCount) + 1.0) {
        completionHandler(batteryLevel: fullBattery)
      }
    }
  }
}