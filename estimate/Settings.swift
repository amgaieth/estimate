//
//  Settings.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/12/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

var temperatureUnit = String()

class Settings: UIViewController {

    let messageComposer = MessageComposer()

    @IBAction func giveFeedback(sender: AnyObject) {
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }


}
