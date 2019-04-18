//
//  InterfaceController.swift
//  IsTodayMeatballsDay WatchKit Extension
//
//  Created by Simon Kärrman on 2019-04-11.
//  Copyright © 2019 Simon Kärrman. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet var response: WKInterfaceLabel!
    private var responseText: String? {
        didSet{
            guard let responseText = responseText else {return}
            response.setText(responseText)
        }
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        updateLabel()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateLabel()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func updateLabel() {
        print("Reload")
        ApiHandler().getStatus(handler: { message in
            self.responseText = message
        })
    }

}
