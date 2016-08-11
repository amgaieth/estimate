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
    
    var first = String()
    
    var address = String()
    
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
    
    var restaurantArr = [(String, String)]()
    var groceriesArr = [(String, String)]()
    var transportationArr = [(String, String)]()
    var utilitiesArr = [(String, String)]()
    var sportsAndLeisureArr = [(String, String)]()
    var clothingArr = [(String, String)]()
    var rentArr = [(String, String)]()
    var buyApartmentsArr = [(String, String)]()
    var salariesArr = [(String, String)]()
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    func updateTime()   {
        timeLabel.text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
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
    
    func getWeather(urlString: String)   {
        let url = NSURL(string: "http://" + urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)   { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(),   {
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    self.setLabels(data)
                }
            })
        }
        task.resume()
    }

    
    func loadNumbeo(country1: String, city1: String, state1: String)   {
        let attemptedUrl = NSURL(string: "http://www.numbeo.com/cost-of-living/city_result.jsp?country=\(country1)&city=\(city1)%2C+\(state1)")
        
        if let url = attemptedUrl   {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data    {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    if ((webContent?.containsString("Numbeo doesn't have that city in the database")) != nil)  {
                        print("info about this city is unavailble")
                    }
                    else    {
                        let lines = webContent?.componentsSeparatedByString("\n")
                        self.getProducts(lines!)
                    }
                }
            }
            task.resume()
        }
    }
    
    func loadNumbeo(country1: String, city1: String)  {
        let attemptedUrl = NSURL(string: "http://www.numbeo.com/cost-of-living/city_result.jsp?country=\(country1)&city=\(city1)")
        if let url = attemptedUrl   {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data    {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    if ((webContent?.containsString("Numbeo doesn't have that city in the database")) != nil)  {
                        print("info about this city is unavailble")
                    }
                    else    {
                        let lines = webContent?.componentsSeparatedByString("\n")
                        self.getProducts(lines!)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getProducts(lines: [String])  {
        var filteredArray = lines.filter {   $0.containsString("<tr><td")   }
        
        var filteredArrayOfProducts = [String]()
        
        for i in filteredArray.indices  {
            if filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil || filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil {
                filteredArrayOfProducts.append(filteredArray[i])
            }
        }
        
        var x = [String]()
        var y = [String]()
        
        for i in lines.indices {
            if lines[i].containsString("<option value")    {
                x.append(lines[i])
            }
        }
        
        for i in x.indices  {
            if x[i].containsString("selected=\"selected\">")    {
                y.append(x[i])
            }
        }
        
        let currencyArr = y[1].componentsSeparatedByString(" selected=\"selected\">")
        
        let currency = currencyArr[1].stringByReplacingOccurrencesOfString("</option>", withString: "")
        
        var productAndPrice: String
        var productAndPriceArray = [String]()
        
        for i in filteredArrayOfProducts.indices {
            if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil  {
                // remove "</td> <td style=\"text-align: right\" class=\"priceValue \">"
                productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">", withString: "")
                // remove <tr><td>
                productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td>", withString: "")
                productAndPriceArray.append(productAndPrice)
            }
            else if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil   {
                productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">", withString: "")
                productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td class=\"tr_highlighted\">", withString: "")
                productAndPriceArray.append(productAndPrice)
            }
        }
        
        var product: String
        var price: String
        // array that has two elements; the product and the price
        var prodAndpriceArray = [String]()
        
        
        for i in productAndPriceArray.indices   {
            prodAndpriceArray = productAndPriceArray[i].componentsSeparatedByString("  ")
            product = prodAndpriceArray[0]
            price = prodAndpriceArray[1]
            let priceArray = price.componentsSeparatedByString("&")
            price = priceArray[0] + " " + currency
            self.priceAndProduct.append((product, price))
        }
        
        for i in self.priceAndProduct.indices    {
            if i < 8    {
                self.restaurantData.append(self.priceAndProduct[i])
            }
            else if i < 27 && i > 7 {
                self.groceriesData.append(self.priceAndProduct[i])
            }
            else if i < 35 && i > 26    {
                self.transportationData.append(self.priceAndProduct[i])
            }
            else if i < 38 && i > 34    {
                self.utilitiesData.append(self.priceAndProduct[i])
            }
            else if i < 41 && i > 37    {
                self.sportsAndLeisureData.append(self.priceAndProduct[i])
            }
            else if i < 45 && i > 40    {
                self.clothingData.append(self.priceAndProduct[i])
            }
            else if i < 49 && i > 44    {
                self.rentData.append(self.priceAndProduct[i])
            }
            else if i < 51 && i > 48    {
                self.buyApartmentData.append(self.priceAndProduct[i])
            }
            else if i < 53 && i > 50    {
                self.salariesData.append(self.priceAndProduct[i])
            }
        }
        
        self.restaurantArr = self.restaurantData
        self.groceriesArr = self.groceriesData
        self.transportationArr = self.transportationData
        self.utilitiesArr = self.utilitiesData
        self.sportsAndLeisureArr = self.sportsAndLeisureData
        self.clothingArr = self.clothingData
        self.rentArr = self.rentData
        self.buyApartmentsArr = self.buyApartmentData
        self.salariesArr = self.salariesData
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.cityLabel.text = self.address
            self.weatherDescriptionLabel.text = self.descript
            self.temperatureLabel.text = self.temperature

            print("city: \(self.first)")
            print("descript: \(self.descript)")
            print("temperature: \(self.temperature)")
        }
        self.priceAndProduct.removeAll()
        self.restaurantData.removeAll()
        self.groceriesData.removeAll()
        self.transportationData.removeAll()
        self.utilitiesData.removeAll()
        self.sportsAndLeisureData.removeAll()
        self.clothingData.removeAll()
        self.rentData.removeAll()
        self.buyApartmentData.removeAll()
        self.salariesData.removeAll()
    }
    
    

    func setLabels(weatherData: NSData) {
        do  {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: .AllowFragments) as? NSDictionary
            
            if let name = json!["name"] as? String   {
                first = name
            }
            
            if let main = json!["main"] as? NSDictionary {
                if var temp = main["temp"] as? Double   {
                    temp = temp - 273.15
                    temp = (temp * 9.0)/5.0 + 32
                    temperature = String(format: "%.1f", temp)
                    temperature = temperature + "ºF"
                }
            }
            
            if let weather = json!["weather"] as? NSArray  {
                if let description = weather[0]["main"] as? String   {
                    descript = description
                }
            }
        }
        catch (let error as NSError)   {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRestaurant"   {
            let restaurantViewController = segue.destinationViewController as! Restaurant
            restaurantViewController.restaurantData = restaurantArr
        }
        else if segue.identifier == "toGroceries"   {
            let groceriesViewController = segue.destinationViewController as! Groceries
            groceriesViewController.groceriesData = groceriesArr
        }
        else if segue.identifier == "toTransportation"   {
            let transportationViewController = segue.destinationViewController as! Transportation
            transportationViewController.transportationData = transportationArr
        }
        else if segue.identifier == "toSportsAndLeisure"    {
            let sportsAndLeisureViewController = segue.destinationViewController as! SportsAndLeisure
            sportsAndLeisureViewController.sportsAndLeisureData = sportsAndLeisureArr
        }
        else if segue.identifier == "toUtilities"   {
            let utilitiesViewController = segue.destinationViewController as! Utilities
            utilitiesViewController.utilitiesData = utilitiesArr
        }
    }
    func unwindSelectProblem(segue: UIStoryboardSegue)   {
    }
}

extension DashboardViewController: SelectedCellProtocol {
    func didSelectedCell(text: String) {
        address = text
        city = ""
        
        print("cell clicked; address: \(address)")
        
        // separate the formattedAddress into city, state, country
        let seperatedformattedAddress = address.componentsSeparatedByString(", ")
        
        // countries that use a state
        if seperatedformattedAddress.count == 3 {
            if seperatedformattedAddress[2] == "United States"    {
                first = seperatedformattedAddress[0]        // city
                let second = seperatedformattedAddress[1]       // state
                let third = seperatedformattedAddress[2]        // country
                // if input includes a space
                if first.containsString(" ") || second.containsString(" ") || third.containsString(" ") {
                    let city =  first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let state = second.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let country = third.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    
                    print("city: \(city)")
                    
                    loadNumbeo(country, city1: city, state1: state)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                    
                }
                else    {
                    let city = first
                    let state = second
                    let country = third
                    loadNumbeo(country, city1: city, state1: state)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                    
                }
            }
                // numbeo does not show state names for other countries
            else    {
                let first = seperatedformattedAddress[0]        // city
                let third = seperatedformattedAddress[2]        // country
                
                // if input includes a space
                if first.containsString(" ") || third.containsString(" ") {
                    let city =  first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let country = third.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    loadNumbeo(country, city1: city)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                }
                else    {
                    let city = first
                    let country = third
                    loadNumbeo(country, city1: city)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                }
            }
        }
        else if seperatedformattedAddress.count == 2 {
            let first = seperatedformattedAddress[0]
            let second = seperatedformattedAddress[1]
            
            if first.containsString(" ") || second.containsString(" ") {
                let city = first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                let country = second.stringByReplacingOccurrencesOfString(" ", withString: "+")
                loadNumbeo(country, city1: city)
                getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
            }
            
            else    {
                let city = first
                let country = second
                loadNumbeo(country, city1: city)
                getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
            }
        }
        else    {
            print("fix this")
        }

    }
}
