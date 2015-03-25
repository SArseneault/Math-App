//
//  TestLevelView.m
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "TestLevelView.h"
#import "Map.h"

@interface TestLevelView()

@end

@implementation TestLevelView


//Synth
@synthesize timeLimit;
@synthesize levelName;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: (BOOL) animated];
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    classID = [define stringForKey:@"classID"];
    studentID = [define stringForKey:@"studentID"];
    userName = [define stringForKey:@"studentUsername"];
    
    //Setting the question type
    questionType = @"1";
    
    //Converting the time limit to an integer in seconds
    timeLimitSeconds = [timeLimit intValue] * 60;
    
    //Grabbing the questions from the back end
    [self grabQuestions];
    
    if(questionsInLevel <= 0)
    {
        //Alert the student
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please have your teacher create questions for this level!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        
        //Switch back to the map
        Map *map = [self.storyboard instantiateViewControllerWithIdentifier:@"Map"];
        [self presentViewController:map animated:YES completion:nil];
        
    } else
    {
        
        [self setUpLevel];
    }
    
    
}


//This function calls a php and returns a json string of questions
- (void)grabQuestions
{
    
    

    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/getQuestions.php?username=%@&studentid=%@&classid=%@&level=%@&questiontype=%@", userName, studentID, classID, levelName, questionType];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
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
    
    
    //Setting the total question count
    questionsInLevel = [json count];
    
    NSLog(@"Number of questions: %ld",(long)questionsInLevel);
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//method to setup level
-(void) setUpLevel
{
    
    if(questionsInLevel <= 0)
    {
        //Alert the student
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please have your teacher create questions for this level!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        
        //Switch back to the map
        Map *map = [self.storyboard instantiateViewControllerWithIdentifier:@"Map"];
        [self presentViewController:map animated:YES completion:nil];
        
        
    }
    //set seconds to 0
    seconds = 0;
    
    //set question asked to 0
    questionCount = 0;
    
    //set questions correct to 0
    totalQuestionsCorrect = 0;
    
    //create timer object, call to method increaseTime to increase and display current time spent on level
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0F target:self selector:@selector(increaseTime) userInfo: nil repeats:YES];
    
    //call to generate random number method to start game
    [self generateNumber];
    
}

-(void) generateNumber
{
    
    
    //Extracting the next question information
    operand1 = [[json objectAtIndex:questionCount] objectForKey:@"operand1"];
    operand2 = [[json objectAtIndex:questionCount] objectForKey:@"operand2"];
    Qoperator = [[json objectAtIndex:questionCount] objectForKey:@"operator"];
    questionID = [[json objectAtIndex:questionCount] objectForKey:@"questionID"];
    
    
    NSLog(@"operand1: %@",operand1);
    NSLog(@"operand2 :%@",operand2);
    NSLog(@"operator: %@",Qoperator);
    NSLog(@"QuestionID: %@",questionID);
    
    //Checking for divide by 0
    if ([Qoperator isEqualToString:@"/"] && [operand2 isEqualToString:@"0"])
        Qoperator  = @"+";
    
    
    //Converting the string to an integer
    valueOne = [operand1 integerValue];
    valueTwo = [operand2 integerValue];
    
    
    //displays the random numbers
    firstNumber.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumber.text =[NSString stringWithFormat:@"%ld",valueTwo];
    operatorLabel.text = [NSString stringWithFormat:@"%@",Qoperator];
    
    //clear user input textbox
    userInput.text = @"";
    
    //increment question counter
    questionCount++;
    
}

-(IBAction)submitAnswer
{
    
    
    //calulate answer
    if ([Qoperator isEqualToString:@"+"])
        correctAnswer =valueOne +valueTwo;
    else if ([Qoperator isEqualToString:@"-"])
        correctAnswer =valueOne - valueTwo;
    else if ([Qoperator isEqualToString:@"*"])
        correctAnswer =valueOne * valueTwo;
    else if ([Qoperator isEqualToString:@"/"])
        correctAnswer =valueOne / valueTwo;
    
    
   
    NSLog(@"Answer: %ld",correctAnswer);
    
    //get user input
    userAnswer =([userInput.text integerValue]);
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //increase questions answered correctly
        totalQuestionsCorrect++;
        
        
    }
    else
    {
        
    }
    
    //call method to check for end of practice section
    [self isEndCheck];
    
    
}

-(void) isEndCheck
{
    //CHECK IF QUESTION COUNT IS AT 5(FOR TESTING ONLY)
    if(questionCount == questionsInLevel)
    {
        //call method to display end results
        [self endResult];
        
    }
    else
    {
        //call generate Number method to create new question
        [self generateNumber];
    }
    
    
}

//end result method that displays results, right/wrong and time taken to complete
-(void) endResult
{
    //stop timer
    [timer invalidate];
    
    //alert to show that the practice section is over
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Practice Over" message:[NSString stringWithFormat:@"You got %ld out of %ld questions correct\n Total Time: %ld seconds", totalQuestionsCorrect, questionsInLevel, seconds] delegate:self cancelButtonTitle:@"PlayAgain?" otherButtonTitles:nil];
    
    
    //set alert tag to endTag
    [alert setTag:1];
    [alert show];
    
    
    NSString *status = @"0";
    //Determine the status
    if(totalQuestionsCorrect == questionsInLevel)
        status = @"1";
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    NSString *classID = [define stringForKey:@"classID"];
    NSString *studentID = [define stringForKey:@"studentID"];
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/LoginPortal/sendLevelProg.php?studentid=%@&classid=%@&level=%@&status=%@&test_time=%@&practice_time=%@&level_type=%@", studentID, classID, levelName, status, [@(seconds) stringValue], [@(seconds) stringValue], questionType];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Stopping the spinnging wheel
    app.networkActivityIndicatorVisible = NO;
    
 
    
}

//timer method to increase time, fired every second
-(void) increaseTime
{
    //increment seconds
    seconds++;
    
    //update timmer label
    labelForTimer.text = [NSString stringWithFormat:@"Time: %ld", seconds];
    
    //Check for timeLimit
    if(seconds == timeLimitSeconds){
        [self endResult];
    }
}

//method for when UIalert button is pressed, helps diferentiate between which one is pressed
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag ==1)   //end alert view was pressed
    {
        //Grabbing the questions from the back end
        [self grabQuestions];
        
        if(questionsInLevel <= 0)
        {
            //Alert the student
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please have your teacher create questions for this level!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
            [alert show];
            
            //Switch back to the map
            Map *map = [self.storyboard instantiateViewControllerWithIdentifier:@"Map"];
            [self presentViewController:map animated:YES completion:nil];
            
        } else
        {
            
            [self setUpLevel];
        }
        
        
    }
    
    
}

//ui button methods
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch = [[event allTouches] anyObject];
    button1.center= [myTouch locationInView:self.view];
}
- (IBAction)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    //[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}
@end
