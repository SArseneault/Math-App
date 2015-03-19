//
//  ClassLogin.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassLogin : UIViewController
{
    
    //Creating outlets for both the username and password fields
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    //Dictionary to store retreived passwords
    NSDictionary *credentialsDictionary;
    NSString *strURL;
}

@property (nonatomic, strong) NSString *strURL;



//Methods
- (IBAction)Login;

@end

