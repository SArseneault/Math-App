//
//  ViewController.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "HomeView.h"

@interface ViewController ()

@end

@implementation ViewController



//Automatically called after screenload
- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    NSString *strURL = [NSString stringWithFormat:@"http://192.168.0.114/LoginPortal/test.php?userName=%@&password=%@", usernameField.text, passwordField.text];
    
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
        
        
        //Setting homeview controller object
        HomeView *HV = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
        
        //Set the username string
        HV.usernameLabel.text = usernameField.text;
        HV.username = usernameField.text;
        
        //Present the view controller
        [self presentViewController:HV animated:YES completion:nil];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The password is incorrect or the username doesn't exist." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

//Releasing property data
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}


@end
