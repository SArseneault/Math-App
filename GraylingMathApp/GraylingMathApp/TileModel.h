//
//  TileModel.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileModel : NSObject

@property (nonatomic, assign) int value;

- (instancetype)initWithValue:(int)value;

@end
