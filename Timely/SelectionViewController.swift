//
//  ViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    @IBOutlet var addTimingButton: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    var currentTiming: Timing? {
        didSet {
            guard let currentTiming = currentTiming else {
                addTimingButton.setTitle(nil, for: .normal)
                addTimingButton.backgroundColor = nil
                return
            }
            addTimingButton.setTitle(currentTiming.name, for: .normal)
            addTimingButton.backgroundColor = currentTiming.color
        }
    }
    
    var timings = [Timing]() {
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
    var buttons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            buttons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        timings = [.superLate, .late, .onTime, .early, .superEarly]
    }
    
    
    // MARK: - Helpers
    @objc func timingSelectionChanged(_ sender: UIButton) {
        guard let selectedIndex = buttons.firstIndex(of: sender) else {
            preconditionFailure("Button index out of range.")
        }
        
        currentTiming = timings[selectedIndex]
    }
    
}

