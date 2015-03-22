//
//  TypeSelect.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeSelect.h"
#import "PracticeLevelView.h"
#import "TestLevelView.h"

@interface TypeSelect()

@end

@implementation TypeSelect

//Synthesizing the timelimit
@synthesize timeLimit;

//Automatically called after screenload
- (void)viewDidLoad
{
    
    
    
}

- (IBAction)goToPractice:(id)sender {
    
    //Creating a homeview object
    PracticeLevelView *PL = [self.storyboard instantiateViewControllerWithIdentifier:@"PracticeLevelView"];
    
    //Passing the timelimit to the storyboard
    PL.timeLimit = timeLimit;
}

- (IBAction)goToTest:(id)sender {
    
    //Creating a homeview object
    TestLevelView *TL = [self.storyboard instantiateViewControllerWithIdentifier:@"TestLevelView"];
    
    //Passing the timelimit to the storyboard
    TL.timeLimit = timeLimit;
    
}
@end

