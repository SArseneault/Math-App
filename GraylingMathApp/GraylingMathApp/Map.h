//
//  Map.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Map : UIViewController <UIAlertViewDelegate>
{
    NSMutableArray * levelInfoJson;
    NSInteger numberOfLevels;
}

@end
