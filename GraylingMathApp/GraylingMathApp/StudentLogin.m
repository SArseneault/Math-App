//
//  StudentLogin.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//
#import "baseURL.h"
#import "StudentLogin.h"
#import "AppDelegate.h"
#import "HomeView.h"


@interface StudentLogin ()

@end

@implementation StudentLogin


//Automatically called after screenload
- (void)viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:(BOOL) animated];
    
    
    
    
    //Displaying the username
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    studentUsername = [define stringForKey:@"studentUsername"];
    studentPassword = [define stringForKey:@"studentPassword"];
    loginCheck = [define stringForKey:@"isStudentLoggedIn"];
    
    NSLog(@"HELLO: %@",loginCheck);
    
    
    //If the class is already logged in then check the credidentals and move to the next screen
    if ([loginCheck isEqualToString:@"TRUE"]) {
        
        strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"logStudentIn.php?userName=%@&password=%@", studentUsername, studentPassword]];
        strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSLog(@"%@",strURL);
        
        [self executeUrlRequest];
        
        if ([strResult isEqualToString:@"1"]) {
            
            //Creating a homview controller object
            HomeView *HV = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
            [self presentViewController:HV animated:YES completion:nil];
        }
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) executeUrlRequest
{
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    NSLog(@"%@",dataURL);
    
    
    // to receive the returend value
    strResult =  [ [NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    //Logging result
    NSLog(@"Results:");
    NSLog(@"%@", strResult);
}


//Method that is called after the login button is selected
- (IBAction)Login
{
    
    // create string contains url address for php file, the file name is phpFile.php, it receives parameter :name
    strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"logStudentIn.php?userName=%@&password=%@", usernameField.text, passwordField.text] ];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@",strURL);
    
    
    //Attemp to log the student in
    [self executeUrlRequest];
    
    
    //Prompting user with either success or failed
    if ([strResult isEqualToString:@"1"]) {
        [self promptStudent];
        
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"isStudentLoggedIn"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The password is incorrect or the class doesn't exist." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void) promptStudent
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Successful" message:@"Welcome" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
    
    //Storing the class credentials
    [[NSUserDefaults standardUserDefaults] setObject:usernameField.text forKey:@"studentUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:passwordField.text forKey:@"studentPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:@"TRUE" forKey:@"isStudentLoggedIn"];
    
    //Creating a homeview controller object
    HomeView *HV = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    
    
    
    //Present the view controller
    [self presentViewController:HV animated:YES completion:nil];
    
    
    
    
}

//Releasing property data
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}


@end
