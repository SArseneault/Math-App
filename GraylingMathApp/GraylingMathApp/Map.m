//
//  Map.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "TypeSelect.h"

@interface Map()

@end

@implementation Map

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Grab the level infomation
    [self getLevelData];
    
    
    
    //Drawing a button for each level
    [self drawLevelButtons];
 
}

//Action for the buttons
- (void)buttonPressed:(UIButton *)button {
    
    //Setting the button
    UIButton *theButton = (UIButton *)button;
    
    //SEtting the tab
    int tag = theButton.tag;
    NSLog(@"%d", tag);
    
    //Grabbing the time limit
    NSString *timeLimit = [[json objectAtIndex:tag] objectForKey:@"timeLimit"];
    NSLog(@"timeLimit: %@",timeLimit);
    
    
    //Creating a homeview object
    TypeSelect *TS = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeSelect"];
    
    //Passing the timelimit to the storyboard
    TS.timeLimit = timeLimit;

    //Present the view controller
    [self presentViewController:TS animated:YES completion:nil];

    
    

    
    //[theButton removeFromSuperview];
}

//Draws a button for each level found
- (void)drawLevelButtons
{
    
    NSInteger xPosition = 60;
    
    //Creating variables to store level info
    NSString * levelName;
   
    
    //Loop through each level
    for(int i = 0; i < numberOfLevels; i++) {
        
        //Setting the level info
        levelName = [[json objectAtIndex:i] objectForKey:@"levelName"];
        
        
        
        //Creating the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:levelName forState:UIControlStateNormal];
        [button sizeToFit];
        [button setTag:i];
        button.center = CGPointMake(320/2, xPosition);
        
        // Add an action in current code file (i.e. target)
        [button addTarget:self action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        
        //Incrementing the xposition
        xPosition += 60;
        
        [self.view addSubview:button];
    }
    
}

//Grabs all the level data
- (void)getLevelData
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
    
    //Setting the total level count
    numberOfLevels = [json count];
    
    
    //Displaying the json array
    NSLog(@"%@", json);
}



@end