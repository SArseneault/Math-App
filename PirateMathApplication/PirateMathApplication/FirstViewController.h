//
//  FirstViewController.h
//  PirateMathApplication
//
//  Created by Samuel Arseneault on 2/9/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
{
    
    IBOutlet UITextField *textFeild1;
    IBOutlet UITextField *textFeild2;
    IBOutlet UILabel *label;
}

//Declare functions to calculate and clear, IBAction means clear
-(IBAction) calculate;
-(IBAction) clear;


@end

