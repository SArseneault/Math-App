//
//  StudentLogin.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "StudentLogin.h"
#import "AppDelegate.h"
#import "HomeView.h"
#import "userData.h"
#import "userDataPraser.h"


@interface StudentLogin ()

@end

@implementation StudentLogin


//Synthesizing the label names from the header file
@synthesize usernameLabel;

//Synthesizing the username
@synthesize username;

//Synthesizing the classname
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Method that is called after the login button is selected
- (IBAction)Login
{
    
    // create string contains url address for php file, the file name is phpFile.php, it receives parameter :name
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/logStudentIn.php?userName=%@&password=%@", usernameField.text, passwordField.text];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@",strURL);
    
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    NSLog(@"%@",dataURL);
    
    
    // to receive the returend value
    NSString *strResult =  [ [NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    //Logging result
    NSLog(@"Results:");
    NSLog(@"%@", strResult);
    
    //Storing results into dictionary
    credentialsDictionary = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"password", passwordField.text, nil] forKeys:[NSArray arrayWithObjects:@"username",usernameField.text, nil]];
    
    

    //Prompting user with either success or failed
    if ([strResult isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Successful" message:@"Welcome" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
        
        //Creating a homeview object
        HomeView *HV = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
        
        //Setting the fields inside of the homeview object
        HV.usernameLabel.text = usernameField.text;
        HV.username = usernameField.text;
        HV.classname = classname;
        
        
        //Storing the class credentials
        [[NSUserDefaults standardUserDefaults] setObject:usernameField.text forKey:@"studentUsername"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordField.text forKey:@"studentPassword"];
        
        //Grab the student and class id's
        [self getSessionInfo];
        
        
        
        //Present the view controller
        [self presentViewController:HV animated:YES completion:nil];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The password is incorrect or the username doesn't exist." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

//Grabbing and storing the session info
- (void)getSessionInfo
{
    //Looking up class and student name
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *className = [define stringForKey:@"className"];
    NSString *userName = [define stringForKey:@"studentUsername"];
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getSessionInfo.php?username=%@&classname=%@", userName, className];
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
    
    //Extracting the student and class id's
    NSString * classID= [[json objectAtIndex:0] objectForKey:@"class_id"];
    NSString * stuID= [[json objectAtIndex:1] objectForKey:@"student_id"];
    
    NSLog(@"%@", classID);
    NSLog(@"%@", stuID);
    
    //Storing the student and class id's
    [[NSUserDefaults standardUserDefaults] setObject:classID forKey:@"classID"];
    [[NSUserDefaults standardUserDefaults] setObject:stuID forKey:@"studentID"];
   
}

//Releasing property data
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}


@end
