//
//  DashboardViewController.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/1/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class DashboardViewController: UITableViewController {
    
    var priceAndProduct = [(String, String)]()
    var restaurantData = [(String, String)]()
    var groceriesData = [(String, String)]()
    var transportationData = [(String, String)]()
    var utilitiesData = [(String, String)]()
    var sportsAndLeisureData = [(String, String)]()
    var clothingData = [(String, String)]()
    var rentData = [(String, String)]()
    var buyApartmentData = [(String, String)]()
    var salariesData = [(String, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        for i in priceAndProduct.indices    {
            if i < 8    {
                restaurantData.append(priceAndProduct[i])
            }
            else if i < 27 && i > 7 {
                groceriesData.append(priceAndProduct[i])
            }
            else if i < 34 && i > 26    {
                transportationData.append(priceAndProduct[i])
            }
            else if i < 38 && i > 34    {
                utilitiesData.append(priceAndProduct[i])
            }
            else if i < 41 && i > 37    {
                sportsAndLeisureData.append(priceAndProduct[i])
            }
            else if i < 45 && i > 40    {
                clothingData.append(priceAndProduct[i])
            }
            else if i < 49 && i > 44    {
                rentData.append(priceAndProduct[i])
            }
            else if i < 51 && i > 48    {
                buyApartmentData.append(priceAndProduct[i])
            }
            else if i < 53 && i > 50    {
                salariesData.append(priceAndProduct[i])
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRestaurant"   {
            let restaurantViewController = segue.destinationViewController as! Restaurant
            restaurantViewController.restaurantData = restaurantData
        }
        else if segue.identifier == "toGroceries"   {
            let groceriesViewController = segue.destinationViewController as! Groceries
            groceriesViewController.groceriesData = groceriesData
        }
        else if segue.identifier == "toTransportation"   {
            let transportationViewController = segue.destinationViewController as! Transportation
            transportationViewController.transportationData = transportationData
        }
        else if segue.identifier == "toSportsAndLeisure"    {
            let sportsAndLeisureViewController = segue.destinationViewController as! SportsAndLeisure
            sportsAndLeisureViewController.sportsAndLeisureData = sportsAndLeisureData
        }
    }
    
    
}
