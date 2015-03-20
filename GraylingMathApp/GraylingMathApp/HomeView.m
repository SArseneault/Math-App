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

//Synthesizing the username
@synthesize username;

//Synthesizing the username
@synthesize classname;

//Synthesizing the json array
@synthesize json;

//Automatically called after screenload
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //userData *currentUserData =[userDataPraser loadData];
    
   // allLevels *curentClassLevel=[levelPraser loadLevels];
    
    //print out current username
    //NSLog(@"Current username %@", currentUserData.userName);
    
    //NSLog(@"Levels avilable %ld", (long)currentUserData.maxLevelsForUser);
    //Setting the label text to passed username value
    usernameLabel.text = username;
    
}


//Method that is called to grab json data
- (IBAction)getQuestionData
{
    
    //Mock information
    NSString *level = [NSString stringWithFormat:@"Level 1"];
    //0 for practice 1 for test
    NSString *questionType = [NSString stringWithFormat:@"0"];
    
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID = [define stringForKey:@"studentID"];
    NSString *userName = [define stringForKey:@"studentUsername"];
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getQuestions.php?username=%@&studentid=%@&classid=%@&level=%@&questiontype=%@", userName, studentID, classID, level, questionType];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
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
    
    
}

- (IBAction)sendQuestionProg:(id)sender {
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID = [define stringForKey:@"studentID"];
    
    
    
    //Mock up progress info
    NSString *level = [NSString stringWithFormat:@"Level 1"];
    NSString *question = [NSString stringWithFormat:@"Q2L1"];
    NSString *answer = [NSString stringWithFormat:@"8"];
    NSString *attempts = [NSString stringWithFormat:@"19"];
    
    
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/sendQuestionProg.php?studentid=%@&classid=%@&level=%@&question=%@&answer=%@&attempts=%@", studentID, classID, level, question, answer, attempts];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    
    //Calling the php file
    NSString *phpResponse = [[NSString alloc] initWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    
    
    //Displaying the string
    NSLog(@"%@", phpResponse);
    
    
}



//Method that is called to grab json data
- (IBAction)getLevelData
{
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID = [define stringForKey:@"studentID"];
    NSString *userName = [define stringForKey:@"studentUsername"];
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;

    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getLevels.php?username=%@&studentid=%@&classid=%@", userName, studentID, classID];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Calling the php file
    //NSString *phpResponse = [[NSString alloc] initWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    
    //Converting the data to json format
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Stopping the spinnging wheel
    app.networkActivityIndicatorVisible = NO;

    
    //Displaying the json array
    NSLog(@"%@", json);
    
   
   
}


- (IBAction)sendLevelProg:(id)sender {
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID = [define stringForKey:@"studentID"];

    
    
    //Mock up progress info
    NSString *level = [NSString stringWithFormat:@"Level 1"];
    NSString *status = [NSString stringWithFormat:@"1"];
    NSString *elapsed_time = [NSString stringWithFormat:@"00:04:18"];
    NSString *test_attempts = [NSString stringWithFormat:@"8"];
    NSString *practice_attempts = [NSString stringWithFormat:@"19"];

    

    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/sendLevelProg.php?studentid=%@&classid=%@&level=%@&status=%@&elapsed_time=%@&test_attempts=%@&practice_attempts=%@", studentID, classID, level, status, elapsed_time, test_attempts, practice_attempts];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    
    //Calling the php file
    NSString *phpResponse = [[NSString alloc] initWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    

    //Displaying the string
    NSLog(@"%@", phpResponse);
    
    
}











@end

