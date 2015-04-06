//
//  TestEnd.h
//  GraylingMathApp
//
//  Created by Samuel Arseneault on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestEnd : UIViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * json;
    NSString * strURL;
}


@property (nonatomic,assign) BOOL PassFail;


//Creating a property for the time limit and level name
@property (strong, nonatomic) NSString *timeLimit;
@property (strong, nonatomic) NSString *levelName;
@property (strong, nonatomic) NSString *levelID;
@property (weak, nonatomic) IBOutlet UILabel *outPutBox;
@property (weak, nonatomic) IBOutlet UIButton *nextLevel;

@property (weak, nonatomic) IBOutlet UITableView *questionTable;

@property (weak, nonatomic) IBOutlet UITableView *chalkBoardTable;


@end