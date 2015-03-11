//
//  LevelSelect.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/11/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "LevelSelect.h"

@interface LevelSelect ()
{
    //Array for the different levels to select from in picker
    NSArray *pickerData;
}

@end



@implementation LevelSelect

@synthesize segementSwitchPorT;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerData = @[@"Level 1", @"Level 2", @"Level 3", @"Level 4", @"Level 5",@"Level 6",@"Level 7",@"Level 8",];
    
    // Connect data
    self.levelPicker.dataSource = self;
    self.levelPicker.delegate = self;
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// the number of columns of data in the level picker
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// the number of rows of data in the level picker
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

//data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

//This is used to recgonize/capture the level picker view selection
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Method is triggered whenever user cahnges the level picker selection, example changes the picker from level 1 to level 2
    //Parameter named row and component is what was selected
    
    
}

-(IBAction) segmentedControlIndex
{
    switch (self.segementSwitchPorT.selectedSegmentIndex) {
        case 0://this would be for the practice section
            break;
        case 1: //this would be for the test section
            break;
        default:
            break;
    }
    
    
}




@end
