//
//  allLevels.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "allLevels.h"

@implementation allLevels

@synthesize levels =_levels;

-(id)init{
    
    //self=[self init];
    
    if((self= [super init]))
    {
        
        _levels =[[NSMutableArray alloc]init];
    //self.levels =[NSMutableArray array];
    }
    
    return self;
}

//-(void) dealloc{
    
    //[super deaaloc]
//}
@end
