//
//  ViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var timingSelector: ImageSelector!
    
    private var currentTiming: Timing? {
        didSet {
            setAddButton(basedOnSelection: currentTiming)
        }
    }
    
    private var timings = [Timing]() {
        didSet {
            timingSelector.images = timings.map { $0.image }
        }
    }
    
    private var timingSelectable: TimingSelectable!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        timings = [.superLate, .late, .onTime, .early, .superEarly]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentTiming = timings[2]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "journalSegue":
            let journalVC = segue.destination as! JournalViewController
            self.timingSelectable = journalVC
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Helpers
    @IBAction private func timingSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex
        currentTiming = timings[selectedIndex]
    }
    
    private func setAddButton(basedOnSelection currentTiming: Timing?) {
        guard let currentTiming = currentTiming else {
            print("Couldn't set add button.")
            addButton.setTitle(nil, for: .normal)
            addButton.backgroundColor = nil
            return
        }
        addButton.setTitle("I'm \(currentTiming.name)", for: .normal)
        addButton.backgroundColor = currentTiming.color
    }
    
    @IBAction func addTimingButtonPressed(_ sender: UIButton) {
        guard let currentTiming = currentTiming else {
            return
        }
        let timingEntry = TimingEntry(timing: currentTiming, date: Date())
        timingSelectable.timingSelected(timingEntry)
    }
}
