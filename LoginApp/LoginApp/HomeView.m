//
//  HomeView.m
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView


//Synthesizing the label names from the header file
@synthesize usernameLabel;

//Synthesizing the username
@synthesize username;


//Automatically called after screenload
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setting the label text to passed username value
    usernameLabel.text = username;
    
}



@end

