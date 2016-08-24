//
//  AppDelegate.swift
//  estimate
//
//  Created by Anouar Mgaieth on 7/14/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCuleRDwKMyu-gimIjwgBm1M7n8eKzxAYA")
        
        let storyboard = grabStoryboard()
        
        // display storyboard
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func grabStoryboard() -> UIStoryboard   {
        // determine screen size
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        var storyboard: UIStoryboard! = nil
        
        switch (screenHeight)
        {
        // iPhone 4s
        case 480:
            storyboard = UIStoryboard(name: "Storyboard3.5Inch", bundle: nil)
        // iPhone 5s
        case 568:
            storyboard = UIStoryboard(name: "Storyboard4Inch", bundle: nil)
        // iPhone 6
        case 667:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        // iPhone 6 Plus
        case 736:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        default:
            // it's an iPad
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        return storyboard
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

