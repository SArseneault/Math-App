//
//  levelPraser.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "levelPraser.h"
#import "allLevels.h"
#import "levelData.h"

@implementation levelPraser

//method to set up file destination for reading and writing

//+(NSString *)dataFilePath:(BOOL)forSave{
    
    
    
    
    
//}

//this method loads the data in the xml file from above
+(allLevels *) loadLevels{
    
    NSLog(@"IN LEVEL PRASER");
    
    NSString *levelName;
    NSInteger levelNumber;
    
    //BOOL unlocked;
    //NSArray *questionData;
    //NSInteger practiceOrTestSelection;
    

    
    
    //Look up class id
    //Looking up class and student name
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    
    
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getAllLevels.php?classid=%@", classID];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    NSLog(@"URL: %@", myURL);
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Converting the data to json format
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
        allLevels *alllevels =[[allLevels alloc]init];
    //Display json array
    NSLog(@"Printing Json Array %@", json);
    
    
    //get nsdata from the json file
    
    //say what you want from the json file
    
    return alllevels;
    
    
    
}

@end
