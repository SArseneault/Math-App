//
//  levelPraser.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>

//this class reads the levels from db and creates the level array


@class allLevels;

@interface levelPraser : NSObject

+(allLevels *) loadLevels;

//Do something to save the data
// +(void)saveData

@end
