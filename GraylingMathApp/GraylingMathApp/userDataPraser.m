//
//  userDataPraser.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/19/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "userDataPraser.h"
#import "userData.h"

@implementation userDataPraser

+(userData*) loadData{
    
    
    NSString *userName;
    NSInteger maxLevelsForUser;
    
    //NSInteger levelUserSelc;
    //NSInteger pracOrTestUserSelc;
    
    //get json array
    
    //Looking up class and student name
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID=[define stringForKey:@"studentID"];
    NSString *jsonUserName = [define stringForKey:@"studentUsername"];
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getLevels.php?username=%@&studentid=%@&classid=%@", jsonUserName, studentID, classID];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Converting the data to json format
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"Username: %@", jsonUserName);
    
    //set the number of levels student can play to array size -1
    maxLevelsForUser = [json count] -1;
    userData *currentUser = [[userData alloc] initWithUserName:jsonUserName
                                              maxLevelsForUser:maxLevelsForUser];
    
    NSLog(@"In Userdata praser");
    NSLog(@"Size of Json Array %ld", [json count]);
    NSLog(@"pRINTING JSON %@", json);
    

                            
    return currentUser;
}

@end
