//
//  TestLevelView.h
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileModel.h"

@interface TestLevelView : UIViewController <UIAlertViewDelegate>
{
    //IBOutlet refers to an empty varaible and method in interface builder
    IBOutlet UILabel *firstNumber; //label first number generated
    IBOutlet UILabel *secondNumber; //label second number generated
    IBOutlet UITextField *userInput; //textbox store user input
    IBOutlet UILabel *labelForTimer; //label for timer
    IBOutlet UILabel *operatorLabel;
    
    
    NSInteger valueOne; //int for first number
    NSInteger valueTwo; //int for second number
    NSInteger correctAnswer; //int for correct answer
    NSInteger userAnswer;   //int for the users input
    NSInteger questionsInLevel; //keeps a track of all the questions grabbed from the level
    NSString *questionType; //Set by the level select view determine whether to grab practice or test questions
    NSInteger questionCount; //keeps track of the number of questions answered
    NSInteger totalQuestionsCorrect; //number of questions answered correctly
    NSInteger seconds; //variable to store seconds used by timer object
    
    NSTimer *timer; //timer object
    
    //Json Array
    NSMutableArray * json;
    
    //Time limit and level name variables from map
    NSString *levelName;
    NSString * timeLimit;
    NSInteger timeLimitSeconds;
    
    //Variables to store extracted question info
    NSString * operand1;
    NSString * operand2;
    NSString * Qoperator;
    NSString * questionID;
    
    //Variables to store session info
    NSString *classID;
    NSString *studentID;
    NSString *userName;
}

//method called to set up leve once screen is loaded
-(void) setUpLevel;

//method to generate numbers
-(void) generateNumber;

//action to check users input
-(IBAction) submitAnswer;

//Creating a property for the json array
@property (nonatomic, strong) NSMutableArray * json;

//Creating a property for the question prog
@property (nonatomic, strong) NSMutableArray * questionProg;
@property (nonatomic, strong) NSMutableDictionary * currentQuestionProg;

//Creating a property for the time limit and level name
@property (strong, nonatomic) NSString *timeLimit;
@property (strong, nonatomic) NSString *levelName;
@property (strong, nonatomic) NSString *levelID;

//Collection View for drag and drop keyboard
@property (weak, nonatomic) IBOutlet UICollectionView *keyBoard;

//communicate with Keyboard view controller to communicate when tile is pressed
-(void)setSelectedTile:(TileModel*)tileModel atPoint:(CGPoint)point;
@property (weak, nonatomic) IBOutlet UIView *inputArea;

@end