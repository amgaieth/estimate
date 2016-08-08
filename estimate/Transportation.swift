//
//  Transportation.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Transportation: UITableViewController {
    
    var transportationData = [(String, String)]()

    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    @IBOutlet weak var product5Label: UILabel!
    @IBOutlet weak var product6Label: UILabel!
    @IBOutlet weak var product7Label: UILabel!
    @IBOutlet weak var product8Label: UILabel!
    
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    @IBOutlet weak var price5Label: UILabel!
    @IBOutlet weak var price6Label: UILabel!
    @IBOutlet weak var price7Label: UILabel!
    @IBOutlet weak var price8Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = transportationData[0].0
        product2Label.text = transportationData[1].0
        product3Label.text = transportationData[2].0
        product4Label.text = transportationData[3].0
        product5Label.text = transportationData[4].0
        product6Label.text = transportationData[5].0
        product7Label.text = transportationData[6].0
        product8Label.text = transportationData[7].0
        
        price1Label.text = transportationData[0].1
        price2Label.text = transportationData[1].1
        price3Label.text = transportationData[2].1
        price4Label.text = transportationData[3].1
        price5Label.text = transportationData[4].1
        price6Label.text = transportationData[5].1
        price7Label.text = transportationData[6].1
        price8Label.text = transportationData[7].1
    }
    
}
