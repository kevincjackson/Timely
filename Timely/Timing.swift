//
//  Timing.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

struct Timing {
    
    var name: String
    var color: UIColor
    var image: UIImage
    
}

enum TimingType: String {
    
    case early
    case late
    case onTime
    case superEarly
    case superLate
    
}

extension Timing {
    
    static let early = Timing(
        name: TimingType.early.rawValue,
        color: UIColor.early!,
        image: UIImage(named: TimingType.early.rawValue)!
    
    )
    static let late = Timing(
        name: TimingType.late.rawValue,
        color: UIColor.late!,
        image: UIImage(named: TimingType.late.rawValue)!
    )
    
    static let onTime = Timing(
        name: TimingType.onTime.rawValue,
        color: UIColor.late!,
        image: UIImage(named: TimingType.onTime.rawValue)!
    )
    
    static let superEarly = Timing(
        name: TimingType.superEarly.rawValue,
        color: UIColor.superEarly!,
        image: UIImage(named: TimingType.superEarly.rawValue)!
    )
    
    static let superLate = Timing(
        name: TimingType.superLate.rawValue,
        color: UIColor.superLate!,
        image: UIImage(named: TimingType.superLate.rawValue)!
    )
}
