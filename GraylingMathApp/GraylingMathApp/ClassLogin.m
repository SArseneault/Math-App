//
//  ClassLogin.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/2/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "ClassLogin.h"
#import "AppDelegate.h"
#import "HomeView.h"
#import "StudentLogin.h"

@interface ClassLogin ()

@end

@implementation ClassLogin


@synthesize strURL;


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
    
    //Displaying the username
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *className = [define stringForKey:@"className"];
    NSLog(@"%@", className);
   
    // create string contains url address for php file, the file name is phpFile.php, it receives parameter :name
    strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/logClassIn.php?userName=%@&password=%@", usernameField.text, passwordField.text];
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
    
    
    

    //Prompting user with either success or failed
    if ([strResult isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Successful" message:@"Welcome" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    
        //Creating a student controller object
        StudentLogin *SL = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentLogin"];
        
        //Set the classname string
        SL.classname = usernameField.text;
        
        //Storing the class credentials
        [[NSUserDefaults standardUserDefaults] setObject:usernameField.text forKey:@"className"];
        [[NSUserDefaults standardUserDefaults] setObject:passwordField.text forKey:@"classPassword"];
    
        
        
        //Present the view controller
        [self presentViewController:SL animated:YES completion:nil];
        
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"isClassLoggedIn"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The password is incorrect or the class doesn't exist." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
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
