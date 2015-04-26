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
#import "KeyBoardCollectionView.h"
#import "TileUiView.h"
#import "TileModel.h"
#import "DestinationController.h"
#import "TestEnd.h"

@interface PracticeLevelView() <UIGestureRecognizerDelegate>
{
    KeyBoardCollectionView *_keyBoardCollectionView;
    
    DestinationController *_destionController;
    
    //data for tiles
    TileModel *_tileModel;
    
    //creates a dragged tile
    TileUiView *_draggedTile;
    
    //Creates a dragged tile for input box
    TileUiView *_draggedInputTile;
    
}

@end

@implementation PracticeLevelView

@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;
//@synthesize timeBool;
@synthesize keyBoard;
@synthesize inputTileCollectionView;
@synthesize resultsBox;
@synthesize replayLevelNotif;
//@synthesize submitButton;

static int inputCount;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL) animated];
    
    //Setting any number of lines for replay notif
    replayLevelNotif.numberOfLines = 0;
    
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
        //hide button
        SubmitButtonPractice.hidden=YES;
    
        [self setUpLevel];
    }
  
    
}

//This function calls the php file which returns a json string of questions
- (void)grabQuestions
{
    
    
    //Creating a string contains url address for php file
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"getquestions.php?username=%@&studentid=%@&classid=%@&level=%@&questiontype=%@", userName, studentID, classID, levelID, questionType]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Lost Wifi Error message
    if(data == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"It appears you have lost internect connection. Please check your wifi connection." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    } else {
    
        //Converting the data to json format
        json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //Displaying the json array
        NSLog(@"%@", json);
    }
    
    
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

    
    //creates actual keyboard layout
    _keyBoardCollectionView = [[KeyBoardCollectionView alloc]initWithCollectionView:self.keyBoard andParentViewController:self];
    
    //Create user input collection view
    _destionController=[[DestinationController alloc]initWithCollectionView:self.inputTileCollectionView andParentViewController:self];
    
    //set up pangesture for dragged tile
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    //Method to create dragged tile
    [self initDraggedTileView];
    
    //Method to create dragged tile for input view
    [self initDraggedInputTileView];
    
    
    //call to generate random number method to start game
    [self generateNumber];
 
    
}

#pragma mark - allow tile to be dragged after intiail press on index
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    
    
    
    //get the point in the testlevel view
    CGPoint touchPoint =[gesture locationInView:self.view];
    
    //calls when tile is moving
    if(gesture.state==UIGestureRecognizerStateChanged && !_draggedTile.hidden)
    {
        
        //tile is dragged
        _draggedTile.center=touchPoint;
        
        //update where card is
        [self updateTileViewDragState:[self isValidDragPoint:touchPoint]];
    }
    if(gesture.state ==UIGestureRecognizerStateEnded && !_draggedTile.hidden)
    {
        //hide dragged tile
        _draggedTile.hidden=YES;
        
        //check to see if it is a valid drop point
        BOOL validDropPoint =[self isValidDragPoint:touchPoint];
        
        if(validDropPoint)
        {
            
            
            NSLog(@"Tile Dropped is %d",_tileModel.value);
            
            //adds the value of the tile to the array/string used for input
            //[self addinputToArray:_tileModel.value];
            SubmitButtonPractice.hidden=NO;
            
            
            [_destionController addModel:_tileModel];
        }
        else{
            
            
            
        }
        
        //Tile Keyboard collection view to make tile avlaible again
        [_keyBoardCollectionView cellDragCompleteWithModel:_tileModel];
    }
    
    
    //started to drag tile from input box
    if(gesture.state==UIGestureRecognizerStateChanged &&!_draggedInputTile.hidden)
    {
        
        _draggedInputTile.center =touchPoint;
        [self updateOutputTileViewDragState:[self isValidDragPointOutput:touchPoint]];
        
        
    }
    
    //stop dragging tile from output box
    if(gesture.state ==UIGestureRecognizerStateEnded && !_draggedInputTile.hidden)
    {
        
        _draggedInputTile.hidden=YES;
        
        //check drop point
        
        BOOL validOutPoutDroppoint =[self isValidDragPointOutput:touchPoint];
        
        if(validOutPoutDroppoint)
        {
            
            
            [_destionController removeTile:_tileModel];
            
            NSInteger numberOfCurrentPracticeTiles=[inputTileCollectionView numberOfItemsInSection:0];
            
            if(numberOfCurrentPracticeTiles==0)
            {
                SubmitButtonPractice.hidden=YES;
            }
            
            
            
        }
        else{
            
            
            // [_destionController reloadData];
        }
        
        
    }
    
    
}

#pragma mark - create tile for the tiles being dragged out of input box
-(void) initDraggedInputTileView{
    
    _draggedInputTile =[[TileUiView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    
    //Set to hidden for initial set up
    _draggedInputTile.hidden = YES;
    
    
    [self.view addSubview:_draggedInputTile];
}
#pragma mark - create tile view that will be dragged
-(void) initDraggedTileView{
    
    
    
    //size of tile 55x55, sligthly bigger than collectionview cells
    _draggedTile =[[TileUiView alloc]initWithFrame:CGRectMake(0, 0, 95, 95)];
    
    //Set to hidden for initial set up
    _draggedTile.hidden = YES;
    
    [self.view addSubview:_draggedTile];
    
}

#pragma mark - method for dragging the input tile around
-(BOOL)isValidDragPointOutput:(CGPoint)point
{
    
    return !CGRectContainsPoint(self.inputTileCollectionView.frame, point);
    
}

#pragma mark- method recgonizes when the tile is over in input area and creates a bool
-(BOOL)isValidDragPoint:(CGPoint)point{
    
    
    NSInteger numberOfTiles =[inputTileCollectionView numberOfItemsInSection:0];
    
    if(numberOfTiles <2)
    {
        //NSLog(@"Number of tiles in collection view ARE: %i", numberOfTiles);
        return CGRectContainsPoint(self.inputTileCollectionView.frame, point);
        
    }
    else{
        return false;
    }
    
}

#pragma mark - draged state for tile view this is where it updates to see where dragged point is
-(void) updateTileViewDragState:(BOOL)validDropPoint{
    
    //If it is a valid drag point highlight tile
    if(validDropPoint){
        [ _draggedTile setHighLight:YES];
    }
    else{
        [ _draggedTile setHighLight:NO];
    }
    
}

-(void)updateOutputTileViewDragState:(BOOL)isValidDragPointOutput{
    
    if(isValidDragPointOutput){
        [_draggedInputTile setOutHighLight:YES];
    }
    else{
        [_draggedInputTile setOutHighLight:NO];
    }
    
}

#pragma mark- method to set up tile in view once keyboard view controller detects a succesfull index in view
-(void)setSelectedTile:(TileModel*)tileModel atPoint:(CGPoint)point{
    
    
    _tileModel=tileModel;
    
    
    if(_tileModel !=nil)
    {
        
        _draggedTile.label.text=[NSString stringWithFormat:@"%d",tileModel.value];
        _draggedTile.center=point;
        _draggedTile.hidden=NO;
        
        //call to update dragged state and if it is a valid drag point
        [self updateTileViewDragState:[self isValidDragPoint:point]];
    }
    
}

#pragma mark - recive from destination what tile has been selected
-(void)setSelectedInputTile:(TileModel*)inputTile atPoint:(CGPoint)point{
    
    
    
    _tileModel =inputTile;
    
    _draggedInputTile.label.text=[NSString stringWithFormat:@"%d", inputTile.value];
    _draggedInputTile.center=point;
    _draggedInputTile.hidden=NO;
    
    [self updateOutputTileViewDragState:[self isValidDragPointOutput:point]];
    
    
    
}

-(void) generateNumber
{

    //Hide Button
    SubmitButtonPractice.hidden=YES;

    //generates random number between 0 and 1
    questionOrientation =arc4random()%2;
    NSLog(@"Question Orientaiton: %d",questionOrientation);
    
    //Setting the questionOrientaiton to zero to force vertical
    questionOrientation = 0;
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
    
    if ([Qoperator isEqualToString:@"/"])
        Qoperator  = @"÷";
    
    //Converting the string to an integer
    valueOne = [operand1 integerValue];
    valueTwo = [operand2 integerValue];
    

    //displays the random numbers
    firstNumber.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumber.text =[NSString stringWithFormat:@"%ld",valueTwo];
    operatorLabel.text = [NSString stringWithFormat:@"%@",Qoperator];
    firstNumberHorz.text =[NSString stringWithFormat:@"%ld",valueOne];
    secondNumberHorz.text =[NSString stringWithFormat:@"%ld",valueTwo];
    operatorLabelHorz.text = [NSString stringWithFormat:@"%@",Qoperator];
    
 
  
    
    //clear user input textbox
    //userInput.text = @"";
    
    
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
    else if ([Qoperator isEqualToString:@"÷"])
        correctAnswer =valueOne / valueTwo;
   
    
    NSLog(@"operator After: %@",Qoperator);
    NSLog(@"Answer: %ld",correctAnswer);
    
    NSInteger testValue =[_destionController getValue];
    

        //userAnswer = ([userInput.text integerValue]);
    userAnswer = (testValue);
 
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //increase questions answered correctly
        totalQuestionsCorrect++;
        
        
        [resultsBox setHidden:NO];
        self.resultsBox.backgroundColor = [UIColor greenColor];
        self.resultsBox.text = @"CORRECT!";
        [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:0.0f];
        
        //call method to check for end of practice section
        [self isEndCheck];
        
       
        
    }
    else
    {
    
        [resultsBox setHidden:NO];
        self.resultsBox.backgroundColor = [UIColor colorWithRed:(169/255.0) green:(34/255.0) blue:(64/255.0) alpha:1];
        self.resultsBox.text = @"Try Again";
        [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:0.0f];
        
        
    }
    
     [_destionController clearInput];
    
  
    
    
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
    NSString *totalTime;
    
    //stop timer
    [timer invalidate];
    
  /*  if(seconds >=60)
    {
        int minutes = seconds/60;
        int tempSec = seconds%60;
        
        if(tempSec<10)
        {
            NSString *totalTime=[NSString stringWithFormat:@"%i:0%i", minutes, tempSec];
        }
        NSLog(@"Greater than 60");
        NSString *totalTime=[NSString stringWithFormat:@"%i:%i", minutes, tempSec];
    }
    else{
        
         NSString *totalTime=[NSString stringWithFormat:@"%i",seconds];
    }*/
    
    
    //Ensuring the textbox is gone when user fades back
    [resultsBox setHidden:YES];
    
    //Displaying the replay box
    [replayLevelNotif setHidden:NO];
    self.replayLevelNotif.backgroundColor = [UIColor colorWithRed:(93/255.0) green:(188/255.0) blue:(210/255.0) alpha:1];
    self.replayLevelNotif.text = @"REPLAYING LEVEL! \nGET READY...";
    [self performSelector:@selector(fadeOutLabels2) withObject:nil afterDelay:2.0f];
    
 
    //Status will always equal 0 for practice
    NSString *status = @"0";

    
    //Creating a string contains url address for php file
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"sendlevelprog.php?studentid=%@&classid=%@&level=%@&status=%@&test_time=%@&practice_time=%@&level_type=%@", studentID, classID, levelID, status, [@(seconds) stringValue], [@(seconds) stringValue], questionType]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    //Lost Wifi Error message
    if(data == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"It appears you have lost internect connection. Please check your wifi connection." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
    }
    
    //Restart level
    [self grabQuestions];
    [self setUpLevel];
    
    
    
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
    }
    
}


-(void)flipOrientaion{
    
    
    if(questionOrientation == 1)
    {
        //Set veritcle labels to hide
        [firstNumber setHidden:YES];
        [secondNumber setHidden:YES];
        [operatorLabel setHidden:YES];
        
        
        //Set horziontal labels to visible
        [firstNumberHorz setHidden:NO];
        [secondNumberHorz setHidden:NO];
        [operatorLabelHorz setHidden:NO];
        
        
    } else {
        
        [firstNumberHorz setHidden:YES];
        [secondNumberHorz setHidden:YES];
        [operatorLabelHorz setHidden:YES];
        
        //Set veritcle labels to hide
        [firstNumber setHidden:NO];
        [secondNumber setHidden:NO];
        [operatorLabel setHidden:NO];
        
    }
    
}

//Function to fade the label
-(void)fadeOutLabels
{   resultsBox.alpha = 1;
    [UIView animateWithDuration:2.0
                          delay:0.0  /* do not add a delay because we will use performSelector. */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         resultsBox.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished) {
                         //do nothings
                         
                         
                     }];
}

//Function to fade the label
-(void)fadeOutLabels2
{   resultsBox.alpha = 1;
    [UIView animateWithDuration:1.0
                          delay:0.0  /* do not add a delay because we will use performSelector. */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         resultsBox.alpha = 0.0;
                         replayLevelNotif.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished) {
                         resultsBox.alpha = 0.0;
                         [replayLevelNotif setHidden:YES];
                         replayLevelNotif.alpha = 1;
                         
                         //[self viewDidAppear:(BOOL)];
                         
                         
                         
                     }];
}




@end
