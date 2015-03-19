//
//  userDataPraser.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
//this class is used to get the users data in json format and set up the users information
@class userData;

@interface userDataPraser : NSObject

+(userData*)loadData;


@end
