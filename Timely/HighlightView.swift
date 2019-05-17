//
//  HighlightView.swift
//  Timely
//
//  Created by Kevin Jackson on 5/16/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class HighlightView: UIView {
    
    var highlightColor = UIColor.yellow.withAlphaComponent(0.6)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
