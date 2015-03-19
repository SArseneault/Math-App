//
//  userData.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/11/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userData : NSObject
{
    NSString *_userName;
    NSInteger _maxLevelsForUser;
    //NSInteger _levelUserSelc;
    //NSInteger _pracOrTestUserSelc;

    
}

//username of student
@property (nonatomic, strong) NSString *userName;

//Max level completed
@property (nonatomic, assign) NSInteger maxLevelsForUser;

-(id)initWithUserName:(NSString*)currentUserName
     maxLevelsForUser:(NSInteger) maxLevels;

//level user selects
//@property (nonatomic, assign) NSInteger levelUserSelc;

//Practice or test
//@property (nonatomic, assign) NSInteger pracOrTestUserSelc;



//-(id)initWithLevelUserSelc:(NSInteger)levelSelc
        //pracOrTestUserSelc:(NSInteger)pracOrTest
         // maxLevelsForUser:(NSInteger)maxLevel
                 // userName:(NSString*)name;



@end
