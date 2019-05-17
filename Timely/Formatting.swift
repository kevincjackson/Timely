//
//  Formatting.swift
//  Timely
//
//  Created by Kevin Jackson on 5/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class TimelyFormatter {
    
    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .full
        df.timeStyle = .short
        return df
    }
}

extension Date {

    var formatted: String {
        return TimelyFormatter.dateFormatter.string(from: self)
    }
}
