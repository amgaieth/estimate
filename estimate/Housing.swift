//
//  Housing.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/12/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Housing: UITableViewController {
    
    var housingData = [(String, String)]()
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    @IBOutlet weak var product5Label: UILabel!
    @IBOutlet weak var product6Label: UILabel!
    
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    @IBOutlet weak var price5Label: UILabel!
    @IBOutlet weak var price6Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = housingData[0].0
        product2Label.text = housingData[1].0
        product3Label.text = housingData[2].0
        product4Label.text = housingData[3].0
        product5Label.text = housingData[4].0
        product6Label.text = housingData[5].0
        
        price1Label.text = housingData[0].1
        price2Label.text = housingData[1].1
        price3Label.text = housingData[2].1
        price4Label.text = housingData[3].1
        price5Label.text = housingData[4].1
        price6Label.text = housingData[5].1  
    }
    
}
