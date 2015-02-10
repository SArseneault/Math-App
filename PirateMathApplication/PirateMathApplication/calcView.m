//
//  calcView.m
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "calcView.h"

@interface Calculator()

@end

@implementation Calculator

-(IBAction)calculate{
    
    float x = ([textFeild1.text floatValue]);
    float c = x+([textFeild2.text floatValue]);
    
    label.text = [[NSString alloc] initWithFormat:@"%2.f",c];
    
    
}

-(IBAction)clear{
    
    textFeild1.text =@"";
    textFeild2.text =@"";
    label.text = @"";
    
}

@end
