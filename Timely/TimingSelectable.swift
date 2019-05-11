//
//  TimingSelectable.swift
//  Timely
//
//  Created by Kevin Jackson on 5/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

// Communicate to the receiver that there's a new TimingEntry.
// Used to pass data forward to JournalViewController
protocol TimingSelectable {
    func timingSelected(_ timingEntry: TimingEntry)
}
