//
//  ImageSelector.swift
//  Timely
//
//  Created by Kevin Jackson on 5/11/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//
//  ImageSelector shows bar of selectable images, and a surrounding highlight
//    which animates upon selection.
//
//  How to use:
//    1. Instantiate using `ImageSelector()`
//    2. Set an array of images.
//    3. Optional: Set an array of matching highlightColors.
//    4. Attach a target-action to the `valueChanged` event.
//

import UIKit

class ImageSelector: UIControl {
    
    // MARK: Public API
    var selectedIndex: Int? {
        didSet {
            guard let index = selectedIndex, (0..<images.count).contains(index)
            else {
                preconditionFailure("Selected index out of range.")
            }
            highlightView.backgroundColor = highlightColor(forIndex: index)
            moveHighlightView(toIndex: index)
        }
    }
    
    var images = [UIImage]() {
        didSet {
            imageButtons = images.map {
                let button = UIButton()
                button.setImage($0, for: .normal)
                button.imageView?.contentMode = .scaleAspectFit
                button.adjustsImageWhenHighlighted = false
                button.addTarget(self, action: #selector(imageButtonPressed(_:)), for: .touchUpInside)
                
                return button
        }}
    }
    
    var highlightColors = [UIColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2
    }
    
    // MARK: - Private
    private var imageButtons = [UIButton]() {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            imageButtons.forEach { selectorStackView.addArrangedSubview($0) }
        }
    }
    
    private let highlightView = HighlightView()
    private var highlightViewXConstraint: NSLayoutConstraint!
    private let selectorStackView = SelectorStackView()
    
    private func commonInit() {
        addSubview(highlightView)
        addSubview(selectorStackView)
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            selectorStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectorStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
            highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
        ])
    }
    
    @objc private func imageButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("ImageSelector: button index out of range.")
        }
        
        // Animate highlight view moving to selected image.
        let highlightAnimator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.75, animations: { [unowned self] in
            self.selectedIndex = buttonIndex
            self.layoutIfNeeded()
            
        })
        highlightAnimator.startAnimation()
        
        
       // Emit event.
        sendActions(for: .valueChanged)
    }

    private func highlightColor(forIndex index: Int) -> UIColor {
        if !(0..<highlightColors.count).contains(index) {
            return highlightView.highlightColor
        }
        else {
            return highlightColors[index]
        }
    }
    
    private func moveHighlightView(toIndex index: Int) {
        let imageButton = imageButtons[index]
        highlightViewXConstraint?.isActive = false
        highlightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
        highlightViewXConstraint.isActive = true
    }
}
