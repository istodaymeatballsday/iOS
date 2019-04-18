//
//  TodayViewController.swift
//  Widget
//
//  Created by Simon Kärrman on 2019-04-18.
//  Copyright © 2019 Simon Kärrman. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var label: UILabel!
    private var responseText: String? {
        didSet{
            guard let responseText = responseText else {return}
            label.text = responseText
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        ApiHandler().getStatus { (response) in
            if(response != self.responseText){
               self.responseText = response
                completionHandler(NCUpdateResult.newData)
            }else{
                completionHandler(NCUpdateResult.noData)
            }
        }
        
    }
    
}
