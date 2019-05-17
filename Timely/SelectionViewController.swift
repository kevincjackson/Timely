// 
//  ViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    @IBOutlet var entryButton: UIButton!
    @IBOutlet var timingSelector: ImageSelector!
    
    private var currentTiming: Timing? {
        didSet {
            setEntryButton(forTiming: currentTiming)
        }
    }
    
    private var timings = [Timing]() {
        didSet {
            timingSelector.images = timings.map { $0.image }
            timingSelector.highlightColors = timings.map { $0.color }
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
        let defaultIndex = 2
        timingSelector.selectedIndex = defaultIndex
        currentTiming = timings[defaultIndex]
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
        guard let selectedIndex = sender.selectedIndex else { return }
        currentTiming = timings[selectedIndex]
    }
    
    private func setEntryButton(forTiming currentTiming: Timing?) {
        guard let currentTiming = currentTiming else {
            entryButton.setTitle(nil, for: .normal)
            entryButton.backgroundColor = nil
            return
        }
        entryButton.setTitle("I'm \(currentTiming.name)", for: .normal)
        
        let buttonColorAnimation = UIViewPropertyAnimator(duration: 0.4, curve: .linear, animations: { [unowned self] in
            self.entryButton.backgroundColor = currentTiming.color
        })
        buttonColorAnimation.startAnimation()
    }
    
    @IBAction func entryButtonPressed(_ sender: UIButton) {
        guard let currentTiming = currentTiming else {
            return
        }
        let timingEntry = TimingEntry(timing: currentTiming, date: Date())
        timingSelectable.timingSelected(timingEntry)
    }
}
