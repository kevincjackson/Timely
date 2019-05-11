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
    @IBOutlet var stackView: UIStackView!
    
    private var currentTiming: Timing? {
        didSet {
            guard let currentTiming = currentTiming else {
                addButton.setTitle(nil, for: .normal)
                addButton.backgroundColor = nil
                return
            }
            addButton.setTitle("I'm \(currentTiming.name)", for: .normal)
            addButton.backgroundColor = currentTiming.color
        }
    }
    
    private var timings = [Timing]() {
        didSet {
            buttons = timings.map {
                let btn = UIButton()
                btn.setImage($0.image, for: .normal)
                btn.imageView?.contentMode = .scaleAspectFit
                btn.adjustsImageWhenHighlighted = false
                btn.addTarget(self, action: #selector(timingSelectionChanged(_:)), for: .touchUpInside)
                return btn
            }
            currentTiming = .onTime
        }
    }
    
    private var buttons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            buttons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    
    private var timingSelectable: TimingSelectable!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        timings = [.superLate, .late, .onTime, .early, .superEarly]
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
    @objc func timingSelectionChanged(_ sender: UIButton) {
        guard let selectedIndex = buttons.firstIndex(of: sender) else {
            preconditionFailure("Button index out of range.")
        }
        
        currentTiming = timings[selectedIndex]
    }
    
    @IBAction func addTimingButtonPressed(_ sender: UIButton) {
        guard let currentTiming = currentTiming else {
            return
        }
        let timingEntry = TimingEntry(timing: currentTiming, date: Date())
        timingSelectable.timingSelected(timingEntry)
    }
}

