//
//  HomeView.h
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIViewController
{
    NSString *className;
    NSString *studentUsername;
    NSString *isClassLoggedIn;
    NSString *isStudentLoggedIn;
    NSString *studentName;
    NSString *classID;
    NSString *studentID;

    
    NSMutableArray * json;
    NSString * strURL;
    
}

//Creating properties for the labels
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;



@end


