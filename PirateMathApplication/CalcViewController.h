//
//  CalcViewController.h
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/27/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface CalcViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UILabel *firstNumber; //label first number generated
    IBOutlet UILabel *secondNumber; //label second number generated
    IBOutlet UITextField *userInput; //textbox store user input

    
    
    NSInteger valueOne; //int for first number
    NSInteger valueTwo; //int for second number
    NSInteger correctAnswer; //int for correct answer
    NSInteger userAnswer;   //int for the users input
    
    
}

//action to generate numbers
-(IBAction) generateNumber;

//action to check users input
-(IBAction) submitAnswer;

@end
