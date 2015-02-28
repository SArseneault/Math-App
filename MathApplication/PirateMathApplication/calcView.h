//
//  calcView.h
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculator : UIViewController
{
    //IBOutlet refers to an empty varaible and method in interface builder

    IBOutlet UITextField *textFeild1;
    IBOutlet UITextField *textFeild2;
    IBOutlet UILabel *label;
    
}

//Declare functions to calculate and clear, IBAction means clear
-(IBAction) calculate;
-(IBAction) clear;

@end