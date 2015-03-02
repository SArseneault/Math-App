//
//  calcView.h
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculator : UIViewController <UIAlertViewDelegate>
{
    //IBOutlet refers to an empty varaible and method in interface builder
    IBOutlet UILabel *firstNumber; //label first number generated
    IBOutlet UILabel *secondNumber; //label second number generated
    IBOutlet UITextField *userInput; //textbox store user input
    IBOutlet UILabel *labelForTimer; //label for timer
    
    NSInteger valueOne; //int for first number
    NSInteger valueTwo; //int for second number
    NSInteger correctAnswer; //int for correct answer
    NSInteger userAnswer;   //int for the users input
    NSInteger questionCount; //keeps track of the number of questions answered
    NSInteger totalQuestionsCorrect; //number of questions answered correctly
    NSInteger seconds; //variable to store seconds used by timer object
    
    NSTimer *timer; //timer object
    
    
}

//method called to set up leve once screen is loaded
-(void) setUpLevel;

//method to generate numbers
-(void) generateNumber;

//action to check users input
-(IBAction) submitAnswer;


@end