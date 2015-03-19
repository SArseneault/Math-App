//
//  HomeView.h
//  LoginApp
//
//  Created by Samuel Arseneault on 2/28/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIViewController

//Creating properties for the labels
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

//Creating property for the strings which store username and password
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *classname;

//Creating a propertie for the json array
@property (nonatomic, strong) NSMutableArray * json;



@end


