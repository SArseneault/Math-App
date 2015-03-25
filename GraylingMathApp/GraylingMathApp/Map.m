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
    
    //Setting the tab
    int tag = theButton.tag;
    NSLog(@"%d", tag);
    
    //Setting the label
    NSString * levelName = theButton.titleLabel.text;
    NSLog(@"%@", levelName);
    
    //Grabbing the time limit
    NSString *timeLimit = [[levelInfoJson objectAtIndex:tag] objectForKey:@"timeLimit"];
    NSLog(@"timeLimit: %@",timeLimit);
    
    
    //Creating a homeview object
    TypeSelect *TS = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeSelect"];
    
    //Passing values to the timelimit to the storyboard
    TS.timeLimit = timeLimit;
    TS.levelName = levelName;

    //Present the view controller
    [self presentViewController:TS animated:YES completion:nil];

    
    //[theButton removeFromSuperview];
}

//Action for the buttons
- (void)buttonPressed2:(UIButton *)button {
    
    //Setting the button
    UIButton *theButton = (UIButton *)button;
    
    //alert to show that the level is not selectable
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Level Locked!" message:[NSString stringWithFormat:@"Please complete the previous level with ALL of the questions right to move onto the this level."] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    
    
    //Show the alert
    [alert show];
    
    
}


//Draws a button for each level found
- (void)drawLevelButtons
{
    
    NSInteger xPosition = 60;
    
    //Creating variables to store level info
    NSString * levelName;
    NSString * prevlevelStatus;
   
    
    //Loop through each level
    for(int i = 0; i < numberOfLevels; i++) {
        
        //Setting the level info
        levelName = [[levelInfoJson objectAtIndex:i] objectForKey:@"levelName"];
        if(i>0)
            prevlevelStatus = [[levelInfoJson objectAtIndex:i-1] objectForKey:@"levelStatus"];
        
       
        
        //Creating the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(2210.0, 360.0, 150.0, 60.0);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [button.titleLabel setFont:[UIFont fontWithName:@"chalkboard SE" size:13.0]];
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:levelName forState:UIControlStateNormal];
        [button sizeToFit];
        [button setTag:i];
        button.center = CGPointMake(320/2, xPosition);
        
        
        // Add an action in current code file (i.e. target)
       if ( ([prevlevelStatus isEqualToString:@"1"]) || (i == 0))
       {
           [button addTarget:self action:@selector(buttonPressed:)
            forControlEvents:UIControlEventTouchUpInside];
       } else {
           [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
           
           [button addTarget:self action:@selector(buttonPressed2:)
            forControlEvents:UIControlEventTouchUpInside];
       }
        
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
    
    NSLog(@"%@", strURL);
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Calling the php file
    //NSString *phpResponse = [[NSString alloc] initWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    
    //Converting the data to json format
    levelInfoJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //Stopping the spinnging wheel
    app.networkActivityIndicatorVisible = NO;
    
    //Setting the total level count
    numberOfLevels = [levelInfoJson count];
    
    
    //Displaying the json array
    NSLog(@"%@", levelInfoJson);
}



@end