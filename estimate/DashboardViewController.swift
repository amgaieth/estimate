//
//  DashboardViewController.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/1/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit
import GoogleMaps

class DashboardViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    var city = String()
    var temperature = String()
    var descript = String()
    
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
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = city
        weatherDescriptionLabel.text = descript
        temperatureLabel.text = temperature
        
        // create different array for the different categories
        for i in priceAndProduct.indices    {
            if i < 8    {
                restaurantData.append(priceAndProduct[i])
            }
            else if i < 27 && i > 7 {
                groceriesData.append(priceAndProduct[i])
            }
            else if i < 35 && i > 26    {
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
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    func updateTime()   {
        timeLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        searchResultController = SearchResultsController()
//        searchResultController.delegate = self
    }
    
    @IBAction func searchWithAdress(sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.presentViewController(searchController, animated: true, completion: nil)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error: NSError?) -> Void in
            
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            
            self.searchResultController.reloadDataWithArray(self.resultsArray)
            
        }
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
    
    func unwindSelectProblem(segue: UIStoryboardSegue)   {
        
    }
}
