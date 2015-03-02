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
    // Do any additional setup after loading the view, typically from a nib.
    
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
    //set question asked to 0
    questionCount = 0;
    
    //set timer to 0, THIS WILL CHANGE IF IT IS A TEST
    

}

-(IBAction) generateNumber
{
    //generates random number between 0 and 10
    valueOne =arc4random()%10;
    valueTwo=arc4random()%10;
    
    //displays the random numbers
    firstNumber.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumber.text =[NSString stringWithFormat:@"%ld",valueTwo];
    
    
}

-(IBAction)submitAnswer
{
    //find and store answer
    correctAnswer =valueOne +valueTwo;
    
    //take user input
    userAnswer =([userInput.text integerValue]);
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //alert to show that the user was correct
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct!" message:[NSString stringWithFormat:@"%ld + %ld = %ld",valueOne,valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        //alert to show the users input was wrong
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:[NSString stringWithFormat:@"%ld + %ld = %ld",valueOne,valueTwo,correctAnswer] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [alert show];
    }
    
    
}


@end
