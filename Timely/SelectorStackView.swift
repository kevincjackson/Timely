//
//  SelectorStackView.swift
//  Timely
//
//  Created by Kevin Jackson on 5/17/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class SelectorStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = 12.0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
