//
//  ViewController.m
//  finalJson
//
//  Created by Kelly Markaity on 3/16/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self jsonFormat];
}

-(void) jsonFormat
{
    
    //file path for json file
        NSString * filePath =[[NSBundle mainBundle] pathForResource:@"testuser" ofType:@"json"];
    
    //Download json into NSdata format
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:filePath];

    NSError *error;
    
    //Data to Dictonary
    NSMutableDictionary *allUsers = [NSJSONSerialization
                                       JSONObjectWithData:JSONData
                                       options:NSJSONReadingMutableContainers
                                       error:&error];

    if(error)
    {
      NSLog (@"%@", [error localizedDescription]);
    }
    else{
        //Dictonary to array
        NSArray * class1 = allUsers[@"class_1"];
        
        //loop through class array to find username
        
        
        //for testing purposes
        for(NSDictionary *theClass in class1)
        {
            
            NSLog(@"----");
            NSLog(@"Username: %@", theClass[@"username"] );
            NSLog(@"StudentID: %@", theClass[@"studentID"] );
            NSLog(@"Level Count: %@", theClass[@"levelCount"] );
            NSLog(@"----");
        
        }
        
    NSLog (@"array size is %lu", (unsigned long)[class1 count]);
        
        //display object at index 0 of the class1 array
        NSLog(@"Data: %@", class1[0]);
        
    }
    

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
