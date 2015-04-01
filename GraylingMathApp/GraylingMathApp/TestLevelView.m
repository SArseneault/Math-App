//
//  TestLevelView.m
//  PirateMathApplication
//
//  Created by Kelly Markaity on 2/10/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//
#import "baseURL.h"
#import "TestLevelView.h"
#import "Map.h"
#import "KeyBoardCollectionView.h"
#import "TileUiView.h"
#import "TileModel.h"

@interface TestLevelView()<UIGestureRecognizerDelegate>
{
    KeyBoardCollectionView *_keyBoardCollectionView;
    
    //data for tiles
    TileModel *_tileModel;
    
    //creates a dragged tile
    TileUiView *_draggedTile;
    
    //Create array to store numbers inputed from dragged tiles
    NSMutableArray *userInputArray;
    
    //create string to store users input
    NSMutableString *userInputString;
    
    
}

@end

@implementation TestLevelView


//Synth
@synthesize timeLimit;
@synthesize levelName;
@synthesize levelID;
@synthesize questionProg;
@synthesize currentQuestionProg;

//Sythensize Keyboard
@synthesize keyBoard;

//uiview for input area
@synthesize inputArea;

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

#pragma mark- method to set up tile in view once keyboard view controller detects a succesfull index in view
-(void)setSelectedTile:(TileModel*)tileModel atPoint:(CGPoint)point{
    
    NSLog(@"Tile is Recviced");
    _tileModel=tileModel;
    
    NSLog(@"Recived tile call");
    if(_tileModel !=nil)
    {
        NSLog(@"Making tile visible");
        _draggedTile.label.text=[NSString stringWithFormat:@"%d",tileModel.value];
        _draggedTile.center=point;
        _draggedTile.hidden=NO;
        
        //call to update dragged state and if it is a valid drag point
        [self updateTileViewDragState:[self isValidDragPoint:point]];
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

#pragma mark- method recgonizes when the tile is over in input area and creates a bool
-(BOOL)isValidDragPoint:(CGPoint)point{
    
    NSLog(@"Checking input area");
    
    return CGRectContainsPoint(self.inputArea.frame, point);
    
}

#pragma mark - allow tile to be dragged after intiail press on index
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



//This function calls a php and returns a json string of questions
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
    
    //Ceating a new question prog array
    questionProg = [[NSMutableArray alloc]initWithCapacity:questionCount];
    
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
    NSLog(@"cREATING KEYBOARD");
    _keyBoardCollectionView = [[KeyBoardCollectionView alloc]initWithCollectionView:self.keyBoard andParentViewController:self];
    
    //call to generate random number method to start game
    [self generateNumber];
    
    //Method to create dragged tile
    [self initDraggedTileView];
    
    //set up pangesture for dragged tile
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
    //Set up array to store tile input
    userInputArray=[[NSMutableArray alloc]init];
    
    //create string to store users input
    userInputString =[[NSMutableString alloc]init];
    
    
    
}

#pragma mark - pan gesture recgonizer for dragged tiles
- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    
    NSLog(@"In hadle pan gesture  of view controller");
    
    //get the point in the testlevel view
    CGPoint touchPoint =[gesture locationInView:self.view];
    
    //calls when tile is moving
    if(gesture.state==UIGestureRecognizerStateChanged && !_draggedTile.hidden)
    {
        NSLog(@"Drag recgonizer moving tile");
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
            
            NSLog(@"VALID DROP AREA RECGONIZED");
            NSLog(@"Tile Dropped is %d",_tileModel.value);
            
            //adds the value of the tile to the array/string used for input
            [self addinputToArray:_tileModel.value];
        }
        else{
            
            NSLog(@"BADDDD DROPP AREA");

        }
        
        //Tile Keyboard collection view to make tile avlaible again
        [_keyBoardCollectionView cellDragCompleteWithModel:_tileModel];
    }
    
    
    
    
}

#pragma mark - input dragged tiles into array and then display current input as text on screen
-(void) addinputToArray:(int)inputNumber{
    
    NSLog(@"Recived call to add input to array, value it: %d", inputNumber);
    NSLog(@"Size of input array is, %lu", (unsigned long)[userInputArray count]);
    
    NSLog(@"Printing the size of string before numbers are added");
    NSUInteger length = [userInputString length];
    NSLog(@"%lu", (unsigned long)length);
    
    //add integer to array
    [userInputArray addObject:[NSNumber numberWithInteger:inputNumber]];
    
    //return userInputArray;
    NSLog(@"Printing out contents of array");
    
    for(int i =0; i <[userInputArray count]; i++)
    {
        
        NSLog(@"Value at: %d, is %@:", i, userInputArray[i]);

    }
    
    [userInputString appendFormat:@"%i", inputNumber];
    
    //userInputString = [NSString stringWithFormat:@"%d", inputNumber];
    
    NSLog(@"Whole array is %@", userInputArray);
    NSLog(@"Printing String: %@", userInputString);
    
    NSLog(@"Size Of string AFTER insert");
    NSUInteger after =[userInputString length];
    
    NSLog(@"%lu", (unsigned long)after);
    
    
    //display the numbers inputed
    userInputLabelDrag.text=userInputString;
    //NSLog(@"@", userInputString);
    
    
    
}

#pragma mark - create tile view that will be dragged
-(void) initDraggedTileView{
    
    NSLog(@"Creating Tile Drag");
    
    //size of tile 55x55, sligthly bigger than collectionview cells
    _draggedTile =[[TileUiView alloc]initWithFrame:CGRectMake(0, 0, 55, 55)];
    
    //Set to hidden for initial set up
    _draggedTile.hidden = YES;
    
    [self.view addSubview:_draggedTile];
    
    
    
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
    
    //Empty string used to store users input
    [userInputString setString:@""];
    
    //update label for value
    userInputLabelDrag.text =userInputString;
    
    

    
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
    //userAnswer =([userInput.text integerValue]);
    
    //get users answer from input drag box
    userAnswer =([userInputString integerValue]);
    
    NSLog(@"Answer from user input: %ld",userAnswer);
    
    //check is users answers are correct
    if(correctAnswer == userAnswer)
    {
        NSLog(@"Answer is correct!");
    }
    else{
        NSLog(@"Answer is incorrect!");
    }
    
    
    //compare to values and display true or false
    if(correctAnswer == userAnswer)
    {
        //increase questions answered correctly
        totalQuestionsCorrect++;
        
        //Creating a new empty question prog dictionary
        currentQuestionProg = [[NSMutableDictionary alloc]initWithCapacity:2];
        
        //Saving the question progress if the question was wrong
        [currentQuestionProg setObject:[NSNumber numberWithInt:-1] forKey:@"User Answer"];
        [currentQuestionProg setObject:[NSNumber numberWithInt:[questionID intValue]] forKey:@"QuestionID"];
        
        
        [questionProg addObject:currentQuestionProg];
        
        
    }
    else
    {
        
        //Creating a new empty question prog dictionary
        currentQuestionProg = [[NSMutableDictionary alloc]initWithCapacity:2];
        
        //Saving the question progress if the question was wrong
        [currentQuestionProg setObject:[NSNumber numberWithInt:userAnswer] forKey:@"User Answer"];
        [currentQuestionProg setObject:[NSNumber numberWithInt:[questionID intValue]] forKey:@"QuestionID"];
        
        
        [questionProg addObject:currentQuestionProg];
        
    }
    
    //call method to check for end of practice section
    [self isEndCheck];
    
    
}

//action to clear current input in input text box
-(IBAction)clearInput{
    
    NSUInteger lengthOfInput =[userInputString length];
    
        NSLog(@"Printing the size of string when button is pressed");
        NSLog(@"Length is %lu", (unsigned long)lengthOfInput);
    
    //Make sure length of string is greater than 0
    if (lengthOfInput >0)
    {
        
        NSLog(@"Length is greater than 0 emptying string");
        //create empty string
        [userInputString setString:@""];
    }
    
    //update the numbers inputed to empty
    userInputLabelDrag.text =userInputString;
    
    
    
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
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"sendlevelprog.php?studentid=%@&classid=%@&level=%@&status=%@&test_time=%@&practice_time=%@&level_type=%@", studentID, classID, levelID, status, [@(seconds) stringValue], [@(seconds) stringValue], questionType]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"%@", strURL);
    
    //Creating acutal url
    NSURL *myURL = [NSURL URLWithString:strURL];
    
    //Calling and storing the json data
    NSData * data = [NSData dataWithContentsOfURL:myURL];
    
    
    //Creating a string contains url address for php file
    NSString *strURL2 = [baseURL stringByAppendingString:[NSString stringWithFormat:@"sendquestionprog.php"]];

    NSLog(@"%@", strURL2);


    //Question progress
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    [arr addObject:questionProg];
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error)
        NSLog(@"%s: JSON encode error: %@", __FUNCTION__, error);
    
    //Create the request
    NSURL *url = [NSURL URLWithString:strURL2];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData2];
    
    //Issue the request
    NSURLResponse *response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error)
        NSLog(@"%s: NSURLConnection error: %@", __FUNCTION__, error);
    
    //Response
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString: %@",responseString);
    

    //Stopping the spinnging wheel
    app.networkActivityIndicatorVisible = NO;
    
 
    
}

//timer method to increase time, fired every second
-(void) increaseTime
{
    //increment seconds
    seconds++;
    
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
        //update timmer label
        labelForTimer.text = [NSString stringWithFormat:@"Time: %ld", (long)seconds];
        
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


@end
