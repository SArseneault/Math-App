//
//  PracticeLevelView.m
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 3/21/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//
#import "baseURL.h"
#import "PracticeLevelView.h"
#import "Map.h"

@interface PracticeLevelView()

@end

@implementation PracticeLevelView

@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL) animated];
    
    //Looking up the class and student id's
    NSUserDefaults *define = [NSUserDefaults standardUserDefaults];
    classID = [define stringForKey:@"classID"];
    studentID = [define stringForKey:@"studentID"];
    userName = [define stringForKey:@"studentUsername"];
    
    
    //Setting the question type
    questionType = @"0";
    
    //Converting the time limit to an integer in seconds
    timeLimitSeconds = [timeLimit intValue] * 60;
    
    NSLog(@"%ld",timeLimitSeconds);
    
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

//This function calls the php file which returns a json string of questions
- (void)grabQuestions
{
    
    
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"getquestions.php?username=%@&studentid=%@&classid=%@&level=%@&questiontype=%@", userName, studentID, classID, levelID, questionType]];
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

    //generates random number between 0 and 1
    questionOrientation =arc4random()%2;
    NSLog(@"Question Orientaiton: %d",questionOrientation);
    [self flipOrientaion];
    
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
    

    //displays the random numbersquesti
    firstNumber.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumber.text =[NSString stringWithFormat:@"%ld",valueTwo];
    operatorLabel.text = [NSString stringWithFormat:@"%@",Qoperator];
    firstNumberHorz.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumberHorz.text =[NSString stringWithFormat:@"%ld",valueTwo];
    operatorLabelHorz.text = [NSString stringWithFormat:@"%@",Qoperator];
    
    
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
    
    NSLog(@"operator After: %@",Qoperator);
    NSLog(@"Answer: %ld",correctAnswer);
    
    //get user input
    if(questionOrientation == 0)
        userAnswer = ([userInput.text integerValue]);
    else
        userAnswer = ([userInputHorz.text integerValue]);
    
    
    
    
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //increase questions answered correctly
        totalQuestionsCorrect++;
        
        
        //alert to show that the user was correct
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct!" message:[NSString stringWithFormat:@"%ld %@ %ld = %ld",valueOne, Qoperator, valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert setTag:2];
        [alert show];
        
    }
    else
    {
        
        //alert to show the users input was wrong
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:[NSString stringWithFormat:@"%ld %@ %ld = %ld",valueOne, Qoperator, valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert setTag:3];
        [alert show];
    }
    
    //Clearing input fields
    userInput.text = nil;
    userInputHorz.text = nil;
    
    
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
    
    //Status will always equal 0 for practice
    NSString *status = @"0";
   
    //Creating and starting the spinning wheel
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"sendlevelprog.php?studentid=%@&classid=%@&level=%@&status=%@&test_time=%@&practice_time=%@&level_type=%@", studentID, classID, levelID, status, [@(seconds) stringValue], [@(seconds) stringValue], questionType]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
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
    
    //seconds to minutes
    if(seconds >=60)
    {
        int minutes = seconds/60;
        int tempSeconds = seconds%60;

        
        if(tempSeconds<10)
        {
            labelForTimer.text=[NSString stringWithFormat:@"Time: %d:0%d",minutes, tempSeconds];

        }
        else{
            //Update timer lable
            labelForTimer.text =[NSString stringWithFormat:@"Time: %d:%d", minutes, tempSeconds];
        }
    }
    else{
        //update timmer label when it is less than one minute
        labelForTimer.text = [NSString stringWithFormat:@"Time: %ld", seconds];
    }
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





-(void)flipOrientaion{
    
    //Clearing input fields
    userInput.text = nil;
    userInputHorz.text = nil;
    
    if(questionOrientation == 1)
    {
        //Set veritcle labels to hide
        [firstNumber setHidden:YES];
        [secondNumber setHidden:YES];
        [userInput setHidden:YES];
        [operatorLabel setHidden:YES];
        [equalVert setHidden:YES];
        
        //Set horziontal labels to visible
        [firstNumberHorz setHidden:NO];
        [secondNumberHorz setHidden:NO];
        [userInputHorz setHidden:NO];
        [operatorLabelHorz setHidden:NO];
        [equalHorz setHidden:NO];
        
        
        
     } else {
        
         [firstNumberHorz setHidden:YES];
         [secondNumberHorz setHidden:YES];
         [userInputHorz setHidden:YES];
         [operatorLabelHorz setHidden:YES];
         [equalHorz setHidden:YES];
         
         //Set veritcle labels to hide
         [firstNumber setHidden:NO];
         [secondNumber setHidden:NO];
         [userInput setHidden:NO];
         [operatorLabel setHidden:NO];
         [equalVert setHidden:NO];
     }
     
    
   
}



@end
