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
    NSArray *json;
    

}

@end



@implementation LevelSelect

@synthesize segementSwitchPorT;
@synthesize levelPicker;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //file path for json file
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"studentLevel" ofType:@"json"];
    
    //this is called to set up json array before picker is created
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfFile:filePath];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    

    // Connect data
    self.levelPicker.dataSource = self;
    self.levelPicker.delegate = self;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//method fetches data and formats json array
-(void)fetchedData:(NSData *)responseData{
    
    //Converting the data to json format
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    NSLog(@"Dict: %@", jsonDict);
    
    _pickerArray =[jsonDict objectForKey:@"levels"];
    
    //NSLog(@"picker array: %@", _pickerArray);
    
    //relaod levlepicker
    [levelPicker reloadAllComponents];
    
}

// the number of columns of data in the level picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// the number of rows of data in the level picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerArray count];

}

//data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //return just the levelNames
    NSDictionary *dict =[_pickerArray objectAtIndex:row];
    //NSLog(@"dit: %@", dict);
    return [dict objectForKey:@"levelName"];
}

//This is used to recgonize/capture the level picker view selection
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Method is triggered whenever user cahnges the level picker selection, example changes the picker from level 1 to level 2
    //Parameter named row and component is what was selected
    
    //get the selected row
    NSString *selectedItem = [self.pickerArray objectAtIndex:[self.levelPicker selectedRowInComponent:0]];
    NSLog(@"%@", selectedItem);
    
    
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
