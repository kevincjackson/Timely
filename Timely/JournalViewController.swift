//
//  ViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {

    @IBOutlet var button: UIButton!
    @IBOutlet var stackView: UIStackView!
    
    var timings = [Timing]() {
        didSet {
            buttons = timings.map {
                let btn = UIButton()
                btn.setImage($0.image, for: .normal)
                btn.imageView?.contentMode = .scaleAspectFit
                btn.adjustsImageWhenHighlighted = false
                return btn
            }
        }
    }
    var buttons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            buttons.forEach { stackView.addArrangedSubview($0) }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timings = [.superLate, .late, .onTime, .early, .superEarly]
        
    }
}

