//
//  StudentLogin.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentLogin : UIViewController
{
    
    //Creating outlets for both the username and password fields
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    //Dictionary to store retreived passwords
    NSDictionary *credentialsDictionary;
}

//Creating properties for the labels
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//Creating property for the strings which store username and password
@property (strong, nonatomic) NSString *username;


//Methods
- (IBAction)Login;

@end

