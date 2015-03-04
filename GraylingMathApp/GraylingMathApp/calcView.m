//
//  calcView.m
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "calcView.h"

@interface Calculator()

@end

@implementation Calculator
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //call to setUpLevel
    [self setUpLevel];
    
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
    seconds =0;
    
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
    //increment question counter
    questionCount++;

    //generates random number between 0 and 10
    valueOne =arc4random()%10;
    valueTwo=arc4random()%10;
    
    //displays the random numbers
    firstNumber.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumber.text =[NSString stringWithFormat:@"%ld",valueTwo];
    
    //clear user input textbox
    userInput.text = @"";

}

-(IBAction)submitAnswer
{
    //calulate answer
    correctAnswer =valueOne +valueTwo;
    
    //get user input
    userAnswer =([userInput.text integerValue]);
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //increase questions answered correctly
        totalQuestionsCorrect++;
        
        //alert to show that the user was correct
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct!" message:[NSString stringWithFormat:@"%ld + %ld = %ld",valueOne,valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert setTag:2];
        [alert show];
        
    }
    else
    {
        //alert to show the users input was wrong
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:[NSString stringWithFormat:@"%ld + %ld = %ld",valueOne,valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert setTag:3];
        [alert show];
    }
    
    //call method to check for end of practice section
    [self isEndCheck];
    

}

-(void) isEndCheck
{
    //CHECK IF QUESTION COUNT IS AT 5(FOR TESTING ONLY)
    if(questionCount == 10)
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Practice Over" message:[NSString stringWithFormat:@"You got %ld out of 10 questions correct\n Total Time: %ld seconds", totalQuestionsCorrect,seconds] delegate:self cancelButtonTitle:@"PlayAgain?" otherButtonTitles:nil];
    
    //set alert tag to endTag
    [alert setTag:1];
    [alert show];
    
}

//timer method to increase time, fired every second
-(void) increaseTime
{
    //increment seconds
    seconds++;
    
    //update timmer label
    labelForTimer.text = [NSString stringWithFormat:@"Time: %ld", seconds];
}

//method for when UIalert button is pressed, helps diferentiate between which one is pressed
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag ==1)   //end alert view was pressed
    {
        //calls to reset level
        [self setUpLevel];
        
    }
    
    
}
@end
