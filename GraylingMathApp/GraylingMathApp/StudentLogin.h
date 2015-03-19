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

//Creating property for the strings which stores student's username
@property (strong, nonatomic) NSString *username;

//Creating property for the strings which stores the classname
@property (strong, nonatomic) NSString *classname;

//Creating a propertie for the json array
@property (nonatomic, strong) NSMutableArray * json;

//Methods
- (IBAction)Login;

@end

