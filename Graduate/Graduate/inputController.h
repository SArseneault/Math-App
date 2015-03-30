//
//  inputController.h
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "TileModel.h"

@interface inputController : NSObject

//tell the view controller where it is located
- (instancetype)initWithUIView:(UIView *)inputView andParentViewController:(ViewController *)parent;

//add tiles to view
-(void)addTile:(TileModel*)model;

@end
