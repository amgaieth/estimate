//
//  Groceries.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Groceries: UITableViewController {
    
    var groceriesData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    @IBOutlet weak var product5Label: UILabel!
    @IBOutlet weak var product6Label: UILabel!
    @IBOutlet weak var product7Label: UILabel!
    @IBOutlet weak var product8Label: UILabel!
    @IBOutlet weak var product9Label: UILabel!
    @IBOutlet weak var product10Label: UILabel!
    @IBOutlet weak var product11Label: UILabel!
    @IBOutlet weak var product12Label: UILabel!
    @IBOutlet weak var product13Label: UILabel!
    @IBOutlet weak var product14Label: UILabel!
    @IBOutlet weak var product15Label: UILabel!
    @IBOutlet weak var product16Label: UILabel!
    @IBOutlet weak var product17Label: UILabel!
    @IBOutlet weak var product18Label: UILabel!
    @IBOutlet weak var product19Label: UILabel!

    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    @IBOutlet weak var price5Label: UILabel!
    @IBOutlet weak var price6Label: UILabel!
    @IBOutlet weak var price7Label: UILabel!
    @IBOutlet weak var price8Label: UILabel!
    @IBOutlet weak var price9Label: UILabel!
    @IBOutlet weak var price10Label: UILabel!
    @IBOutlet weak var price11Label: UILabel!
    @IBOutlet weak var price12Label: UILabel!
    @IBOutlet weak var price13Label: UILabel!
    @IBOutlet weak var price14Label: UILabel!
    @IBOutlet weak var price15Label: UILabel!
    @IBOutlet weak var price16Label: UILabel!
    @IBOutlet weak var price17Label: UILabel!
    @IBOutlet weak var price18Label: UILabel!
    @IBOutlet weak var price19Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in groceriesData.indices {
            print(groceriesData[i])
        }
    }
    
}
