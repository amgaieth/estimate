//
//  SportsAndLeisure.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class SportsAndLeisure: UITableViewController {
    
    var sportsAndLeisureData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!

    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in sportsAndLeisureData.indices {
            print(sportsAndLeisureData[i])
        }
    }
}
