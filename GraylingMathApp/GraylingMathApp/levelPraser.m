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
    
    allLevels *alllevels =[[allLevels alloc]init];
    
    //BOOL unlocked;
    //NSArray *questionData;
    //NSInteger practiceOrTestSelection;
    
    
    
    
    

    
    
    //Look up class id
    //Looking up class and student name
    //NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    //NSString *classID = [define stringForKey:@"classID"];
    
    
   // NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getAllLevels.php?classid//=%@", classID];
    //strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Creating acutal url
    //NSURL *myURL = [NSURL URLWithString:strURL];
    
    //NSLog(@"URL: %@", myURL);
    
    //Calling and storing the json data
    //NSData * data = [NSData dataWithContentsOfURL:myURL];
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"level" ofType:@"json"];
    
    NSError *error = nil;
    
    //load file into NSData object
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    //Converting the data to json format
    NSArray *json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    
    
    //loop through json
    for(NSDictionary * item in json)
    {
        NSLog(@"Item: %@", item);
        NSLog(@"%@",[item objectForKey:@"levelID"]);
        NSLog(@"%@",[item objectForKey:@"levelName"]);
        
        
        //NSArray *levelNameArray =[item objectForKey:@"levelID"];
        //NSArray *levelNumberArray = [item objectForKey:@"levelName"];
        
        
        
        levelNumber = [[item objectForKey:@"levelID"] integerValue];
        levelName = [item objectForKey:@"levelName"];
        
        levelData *leveldata =[[levelData alloc]initWithLevelName:levelName levelNumber:levelNumber];
        
        NSLog(@"printing name %@", leveldata.levelName);
        NSLog(@"printing ID %ld", (long)leveldata.levelNumber);
        
        //add object to level data class
        [alllevels.levels addObject:leveldata];
        //NSLog(@"In loop");
    }

    //Display json array
    NSLog(@"Printing Json Array %@", json);
    
    
    //get nsdata from the json file
    
    //say what you want from the json file
    
    return alllevels;
    
    
    
}

@end
