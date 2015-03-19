//
//  levelData.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "levelData.h"



@implementation levelData

@synthesize levelName=_levelName;
@synthesize levelNumber=_levelNumber;



-(id)initWithLevelName:(NSString*)levelName levelNumber:(NSInteger) levelNumber{
    
    if((self =[super init])){
        
        self.levelName=levelName;
        self.levelNumber=levelNumber;
        //self.unlocked=unlocked;
        //self.questionData=questionData;
        //self.practiceOrTestSelection=practiceOrTestSelection;
    }
    return self;
    
    
}

    


-(void) dealloc{
    
    //[super dealloc];
}

@end
