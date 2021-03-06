//
//  TypeSelect.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//
#import "baseURL.h"
#import <Foundation/Foundation.h>
#import "TypeSelect.h"
#import "PracticeLevelView.h"
#import "TestLevelView.h"

@interface TypeSelect()

@end

@implementation TypeSelect

//Synthesizing the timelimit
@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;
@synthesize practiceButton;
@synthesize testButton;

//Automatically called after screenload
- (void)viewDidLoad
{
    practiceButton.layer.cornerRadius = 5.0f;
    testButton.layer.cornerRadius = 5.0f;
}

- (IBAction)goToPractice:(id)sender {
    

    //Creating a homeview object
    PracticeLevelView *PL = [self.storyboard instantiateViewControllerWithIdentifier:@"PracticeLevelView"];
    
    //Passing values to the timelimit to the storyboard
    PL.timeLimit = timeLimit;
    PL.levelName = levelName;
    PL.levelID = levelID;
    
    //Present the view controller
    [self presentViewController:PL animated:YES completion:nil];
    
}

- (IBAction)goToTest:(id)sender {
    
    //Creating a homeview object
    TestLevelView *TL = [self.storyboard instantiateViewControllerWithIdentifier:@"TestLevelView"];
    
    //Passing values to the timelimit to the storyboard
    TL.timeLimit = timeLimit;
    TL.levelName = levelName;
    TL.levelID = levelID;
    
    //Present the view controller
    [self presentViewController:TL animated:YES completion:nil];
    
}
@end

