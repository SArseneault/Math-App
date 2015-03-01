//
//  ViewController.h
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeView.h"

@interface ViewController : UIViewController
{
    
    //Creating outlets for both the username and password fields
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    //Dictionary to store retreived passwords
    NSDictionary *credentialsDictionary;
}


//Methods
- (IBAction)Login;


@end

