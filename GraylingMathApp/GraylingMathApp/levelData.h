//
//  levelData.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>

//this class is used to set up and store information about a level

@interface levelData : NSObject{
    
    NSString *_levelName;
    NSInteger _levelNumber;

}

@property (nonatomic, copy) NSString *levelName;

@property (nonatomic, assign) NSInteger levelNumber;

-(id)initWithLevelName:(NSString*)levelName levelNumber:(NSInteger) levelNumber;

//@property (nonatomic, assign) bool unlocked;
//@property (nonatomic, copy) NSArray *questionData;
//@property (nonatomic, assign) NSInteger practiceOrTestSelection;

//-(id) initWithLevelName:(NSString *)levelName
               //unlocked:(bool)unlocked
           //questionData:(NSArray*)questionData
//practiceOrTestSelection:(NSInteger) practiceOrTestSelection;




@end
