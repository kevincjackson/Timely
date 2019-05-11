//
//  ImageSelector.swift
//  Timely
//
//  Created by Kevin Jackson on 5/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit
class ImageSelector: UIControl {
    
    var selectedIndex = 0
    
    var images = [UIImage]() {
        didSet {
            imageButtons = images.map {
                let button = UIButton()
                button.setImage($0, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.adjustsImageWhenHighlighted = false
                button.addTarget(self, action: #selector(imageButtonPressed(_:)), for: .touchUpInside)
                
                return button
            }
            
            selectedIndex = 0
        }
    }
    
    private var imageButtons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            imageButtons.forEach { selectorStackView.addArrangedSubview($0)}
        }
    }
    
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(selectorStackView)
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            selectorStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectorStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
    
    @objc private func imageButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("ImageSelector: button index out of range.")
        }
        selectedIndex = buttonIndex
        sendActions(for: .valueChanged)
    }
}
