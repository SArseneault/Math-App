//
//  HomeView.m
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "HomeView.h"


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
    
    
    
    
    //Setting the label text to passed username value
    usernameLabel.text = username;
    
}

//Method that is called to grab json data
- (IBAction)getData
{
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;

    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getLevels.php?username=%@&classname=%@", username, classname];
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



- (IBAction)sendData:(id)sender {
    
    
    //Mock up progress info
    NSString *level = [NSString stringWithFormat:@"Level 1"];
    NSString *status = [NSString stringWithFormat:@"1"];
    NSString *elapsed_time = [NSString stringWithFormat:@"00:04:18"];
    NSString *test_attempts = [NSString stringWithFormat:@"3"];
    NSString *practice_attempts = [NSString stringWithFormat:@"5"];

    

    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/sendLevelProg.php?username=%@&class=%@&level=%@&status=%@&elapsed_time=%@&test_attempts=%@&practice_attempts=%@", username, classname, level, status, elapsed_time, test_attempts, practice_attempts];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    
    //Calling the php file
    NSString *phpResponse = [[NSString alloc] initWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    

    //Displaying the string
    NSLog(@"%@", phpResponse);
    
    
}











@end

