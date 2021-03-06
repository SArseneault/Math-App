//
//  TypeSelect.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TypeSelect : UIViewController <UIAlertViewDelegate>
{
    NSString * levelName;
}

@property (strong, nonatomic) NSString *timeLimit;
@property (strong, nonatomic) NSString *levelName;
@property (strong, nonatomic) NSString *levelID;
@property (strong, nonatomic) IBOutlet UIButton *practiceButton;
@property (strong, nonatomic) IBOutlet UIButton *testButton;

@end
