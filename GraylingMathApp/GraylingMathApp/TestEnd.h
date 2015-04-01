//
//  TestEnd.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestEnd : UIViewController <UIAlertViewDelegate>
{
}


@property (nonatomic,assign) BOOL PassFail;


//Creating a property for the time limit and level name
@property (strong, nonatomic) NSString *timeLimit;
@property (strong, nonatomic) NSString *levelName;
@property (strong, nonatomic) NSString *levelID;

@end