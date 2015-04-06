//
//  TestEnd.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "baseURL.h"
#import "TestEnd.h"
#import "TestLevelView.h"

@interface TestEnd()

@end

@implementation TestEnd
@synthesize PassFail;
@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;
@synthesize outPutBox;
@synthesize nextLevel;
@synthesize chalkBoardTable;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: (BOOL) animated];
    
    //Deciding which buttons to display
    if(PassFail){
        nextLevel.enabled = YES;
        self.outPutBox.backgroundColor = [UIColor greenColor];
        self.outPutBox.text = @"PASS!";
        
        
        //Creating x and y positions
        NSInteger xPosition = 380;
        NSInteger yPosition = 380;
        
        
        //Creating the beggining label
        UILabel *lbl1 = [[UILabel alloc] init];
        [lbl1 setFrame:CGRectMake(0,5,250,70)];
        lbl1.font = [UIFont fontWithName:@"chalkboard SE" size:35.0];
        lbl1.backgroundColor=[UIColor clearColor];
        lbl1.textColor=[UIColor whiteColor];
        lbl1.userInteractionEnabled=YES;
        [self.view addSubview:lbl1];
        lbl1.text = @"Great Job!";
        
        lbl1.center = CGPointMake(xPosition,yPosition);

        
        
        
        
    } else {
        nextLevel.enabled = NO;
        self.outPutBox.backgroundColor = [UIColor colorWithRed:(169/255.0) green:(34/255.0) blue:(64/255.0) alpha:1];
        self.outPutBox.text = @"FAIL";
        [self getQuestionProg];
    }
    
    
    
    
}

- (IBAction)replayLevel:(id)sender {
    
    //Creating a homeview object
    TestLevelView *TL = [self.storyboard instantiateViewControllerWithIdentifier:@"TestLevelView"];
    
    //Passing values to the timelimit to the storyboard
    TL.timeLimit = timeLimit;
    TL.levelName = levelName;
    TL.levelID = levelID;
    
    
    
    
    
    
    
    //Present the view controller
    [self presentViewController:TL animated:YES completion:nil];
}



-(void)getQuestionProg
{
    
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    
    
    //Creating a string contains url address for php file
    strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"getquestionprogress.php?classid=%@&levelid=%@", classID, levelID]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@",strURL);
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    
    //Converting the data to json format
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSLog(@"RESULTS FROM GQP: %@",json);
    
    
    //Setting the total question prog count
    NSInteger* questionProgCount = [json count];
    NSString* attempts = @"";
    NSString* operand1 = @"";
    NSString* operand2 = @"";
    NSString* operator = @"";
    NSString* studentAnswer = @"";
    NSInteger correctAnswer;
    NSInteger valueOne; //int for first number
    NSInteger valueTwo; //int for second number
    
    //Creating x and y positions
    NSInteger xPosition = 245;
    NSInteger yPosition = 240;
    
    
    //Creating the beggining label
    UILabel *lbl1 = [[UILabel alloc] init];
    [lbl1 setFrame:CGRectMake(0,5,300,25)];
    lbl1.font = [UIFont fontWithName:@"chalkboard SE" size:25.0];
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor whiteColor];
    lbl1.userInteractionEnabled=YES;
    [self.view addSubview:lbl1];
    lbl1.text = @"Question    Your Answer";
    
    lbl1.center = CGPointMake(xPosition,yPosition);
    
    
    yPosition = 25;
    xPosition = 125;
    
    chalkBoardTable.rowHeight = 42;
    
    //Loop through each level
    for(int i = 0; i < questionProgCount; i++) {
        
        NSString* Question = @"";
        attempts = [[json objectAtIndex:i] objectForKey:@"attempts"];
        operand1 = [[json objectAtIndex:i] objectForKey:@"operand1"];
        operand2 = [[json objectAtIndex:i] objectForKey:@"operand2"];
        operator = [[json objectAtIndex:i] objectForKey:@"operator"];
        studentAnswer = [[json objectAtIndex:i] objectForKey:@"studentAnswer"];
       
        
        Question = [Question stringByAppendingString:operand1];
        Question = [Question stringByAppendingString:operator];
        Question = [Question stringByAppendingString:operand2];
        Question = [Question stringByAppendingString:@" = "];
        
        
        //Converting the string to an integer
        valueOne = [operand1 integerValue];
        valueTwo = [operand2 integerValue];
        
        //calulate answer
        if ([operator isEqualToString:@"+"])
            correctAnswer =valueOne +valueTwo;
        else if ([operator isEqualToString:@"-"])
            correctAnswer =valueOne - valueTwo;
        else if ([operator isEqualToString:@"*"])
            correctAnswer =valueOne * valueTwo;
        else if ([operator isEqualToString:@"/"])
            correctAnswer =valueOne / valueTwo;
       
        Question = [Question stringByAppendingString:[@(correctAnswer) stringValue]];
        
        
    
        //Question
        UILabel *lbl1 = [[UILabel alloc] init];
        [lbl1 setFrame:CGRectMake(0,5,100,20)];
        lbl1.font = [UIFont fontWithName:@"chalkboard SE" size:20.0];
        lbl1.backgroundColor=[UIColor clearColor];
        lbl1.textColor=[UIColor whiteColor];
        lbl1.userInteractionEnabled=YES;
        //[self.view addSubview:lbl1];
        lbl1.text= Question;

        lbl1.center = CGPointMake(xPosition,yPosition);
        
        [chalkBoardTable insertSubview:lbl1 atIndex:0];
        
    
        
        //Answer
        UILabel *lbl2 = [[UILabel alloc] init];
        [lbl2 setFrame:CGRectMake(0,5,100,20)];
        lbl2.backgroundColor=[UIColor clearColor];
        lbl2.font = [UIFont fontWithName:@"chalkboard SE" size:20.0];
        lbl2.textColor=[UIColor redColor];
        lbl2.userInteractionEnabled=YES;
        //[self.view addSubview:lbl2];
        lbl2.text= studentAnswer;
        
        lbl2.center = CGPointMake(xPosition+150,yPosition);
        
        yPosition += 42;
        
        [chalkBoardTable insertSubview:lbl2 atIndex:0];
        
       
        
       
        
    }

}

@end