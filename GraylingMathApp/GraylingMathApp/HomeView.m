//
//  HomeView.m
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "HomeView.h"
#import "StudentLogin.h"
#import "ClassLogin.h"
#import "FirstViewController.h"
#import "baseURL.h"


@implementation HomeView
{
    
    
}

//Synthesizing the label names from the header file
@synthesize usernameLabel;
@synthesize selectLevel;


//Automatically called after screenload
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Rounded buttons
    selectLevel.layer.cornerRadius = 5.0f;
  
    
    
    //Looking up class and student name
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    className = [define stringForKey:@"className"];
    studentUsername = [define stringForKey:@"studentUsername"];
    
    
    
    //Grabbing the session info
    [self getSessionInfo];
    
    
    //Setting the welcome label to the student's name
    usernameLabel.text = studentName;
    
    
    
}


//Grabbing and storing the session info
- (void)getSessionInfo
{
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    

    
    //Creating a string contains url address for php file
    strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"getsessioninfo.php?username=%@&classname=%@", studentUsername, className]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@",strURL);
    
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
    classID = [[json objectAtIndex:0] objectForKey:@"class_id"];
    studentID = [[json objectAtIndex:1] objectForKey:@"student_id"];
    studentName = [[json objectAtIndex:2] objectForKey:@"studentName"];
   

    //Storing the student and class id's
    [[NSUserDefaults standardUserDefaults] setObject:classID forKey:@"classID"];
    [[NSUserDefaults standardUserDefaults] setObject:studentID forKey:@"studentID"];
    [[NSUserDefaults standardUserDefaults] setObject:studentName forKey:@"studentName"];
    
}



- (IBAction)logOutStudent:(id)sender {
    
    //Set the student logged in variable to false
    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"isStudentLoggedIn"];
    
    //Move onto student login screen
    StudentLogin *SL = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentLogin"];
    [self presentViewController:SL animated:YES completion:nil];
    
    
}
- (IBAction)logOutClass:(id)sender {
    
    //Set the student and class logged in variable to false
    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"isStudentLoggedIn"];
    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"isClassLoggedIn"];
    
    //Move to home screen
    FirstViewController *FVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self presentViewController:FVC animated:YES completion:nil];


}





@end

