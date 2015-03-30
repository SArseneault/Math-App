//
//  ViewController.h
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileModel.h"

@interface ViewController : UIViewController


//this is a method to tell viewcontroller that the keyboard detects a selected cell at the given point
-(void)setSelectedTile:(TileModel*)tileModel atPoint:(CGPoint)point;


@end

