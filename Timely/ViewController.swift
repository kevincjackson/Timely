//
//  ViewController.swift
//  Timely
//
//  Created by Kevin Jackson on 5/10/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Bundle.main.bundlePath
        print(p)
        let fs = try! FileManager.default.contentsOfDirectory(atPath: p)
        print(fs)
    }
}

