//
//  HomeView.m
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "HomeView.h"
#import "userData.h"
#import "userDataPraser.h"
#import "allLevels.h"
#import "levelPraser.h"



@implementation HomeView
{
    

    
}

//Synthesizing the label names from the header file
@synthesize usernameLabel;



//Automatically called after screenload
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Looking up class and student name
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    className = [define stringForKey:@"className"];
    studentUsername = [define stringForKey:@"studentUsername"];
    
    usernameLabel.text = studentUsername;
    
    //Grabbing the session info
    [self getSessionInfo];
    
}


//Grabbing and storing the session info
- (void)getSessionInfo
{
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getSessionInfo.php?username=%@&classname=%@", studentUsername, className];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    
    //Converting the data to json format
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Stopping the spinnging wheel
    app.networkActivityIndicatorVisible = NO;
    
    
    //Displaying the json array
    NSLog(@"%@", json);
    
    //Extracting the student and class id's
    NSString * classID= [[json objectAtIndex:0] objectForKey:@"class_id"];
    NSString * stuID= [[json objectAtIndex:1] objectForKey:@"student_id"];
    
    NSLog(@"%@", classID);
    NSLog(@"%@", stuID);
    
    //Storing the student and class id's
    [[NSUserDefaults standardUserDefaults] setObject:classID forKey:@"classID"];
    [[NSUserDefaults standardUserDefaults] setObject:stuID forKey:@"studentID"];
    
}









@end

