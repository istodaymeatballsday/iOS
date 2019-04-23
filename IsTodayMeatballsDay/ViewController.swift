//
//  ViewController.swift
//  IsTodayMeatballsDay
//
//  Created by Simon Kärrman on 2019-04-11.
//  Copyright © 2019 Simon Kärrman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 128)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(label)
        self.label.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.label.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.label.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func reloadLabel() {
        ApiHandler().getStatus(){ response in
            DispatchQueue.main.async {
                self.label.text = response.msg
            }
        }
    }


}

