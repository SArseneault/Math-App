//
//  TileModel.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "TileModel.h"

@implementation TileModel

- (instancetype)initWithValue:(int)value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

@end
