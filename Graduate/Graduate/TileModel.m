//
//  TileModel.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
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
