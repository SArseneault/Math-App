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
    
    //Variables to store the class name and login check
    NSString *loginCheck;
    NSString *className;
    NSString *classPassword;
    NSString *strResult;
    NSString *strURL;
    
}


//Methods
- (IBAction)Login;

@end

