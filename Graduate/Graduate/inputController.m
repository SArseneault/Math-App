//
//  inputController.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import "inputController.h"

@interface inputController()
{
    ViewController *_parentViewController;
    UIView *_inputView;
    
    NSMutableArray *_tileInputed;
    
    
}

@end
@implementation inputController

-(instancetype)initWithUIView:(UIView *)inputView andParentViewController:(ViewController *)parent{
    
    if(self=[super init]){
        
        _tileInputed=[NSMutableArray array];
        _inputView=inputView;

    
        
        _parentViewController=parent;
        
    }
    
    
    return self;
}

-(void)addTile:(TileModel *)model{
    
    NSLog(@"Adding tiles");
    [_tileInputed addObject:model];
    
    NSLog(@"Size OF ARRAY");
    NSLog(@"%lu", (unsigned long)[_tileInputed count]);
    NSLog(@"%d", model.value);
    
}

@end
