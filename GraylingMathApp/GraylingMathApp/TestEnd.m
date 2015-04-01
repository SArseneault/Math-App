//
//  TestEnd.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "baseURL.h"
#import "TestEnd.h"
#import "TestLevelView.h"

@interface TestEnd()

@end

@implementation TestEnd
@synthesize PassFail;
@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;

- (IBAction)replayLevel:(id)sender {
    
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