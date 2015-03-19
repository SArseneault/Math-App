//
//  userData.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/11/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "userData.h"

@implementation userData

@synthesize userName = _userName;
@synthesize maxLevelsForUser=_maxLevelsForUser;
//@synthesize levelUserSelc=_levelUserSelc;
//@synthesize pracOrTestUserSelc=_pracOrTestUserSelc;

-(id)initWithUserName:(NSString*)currentUserName
     maxLevelsForUser:(NSInteger) maxLevels{
    
    if((self = [super init])){
        self.userName =currentUserName;
        self.maxLevelsForUser=maxLevels;
        
        
    }
    
    return self;
    
}








@end
