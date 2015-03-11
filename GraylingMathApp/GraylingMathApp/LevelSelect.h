//
//  LevelSelect.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/11/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LevelSelect : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

//Picker wheel for selecting level
@property (weak, nonatomic) IBOutlet UIPickerView *levelPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segementSwitchPorT;

-(IBAction) segmentedControlIndex;


@end
