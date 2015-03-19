//
//  allLevels.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>

//this class gets all the levels and puts them into an array

@interface allLevels : NSObject{
    
    NSMutableArray *_levels;
}

@property (nonatomic, retain) NSMutableArray *levels;

@end
