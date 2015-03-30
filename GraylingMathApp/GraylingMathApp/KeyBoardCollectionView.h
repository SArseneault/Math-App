//
//  KeyBoardCollectionView.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestLevelView.h"
#import "TileModel.h"
#import "TestLevelView.h"

@interface KeyBoardCollectionView : NSObject

//method to communinicate between TestlevelView controller and uicollection view controller to notify when a cell has been selected.
- (instancetype)initWithCollectionView:(UICollectionView *)view andParentViewController:(TestLevelView *)parent;

@end
