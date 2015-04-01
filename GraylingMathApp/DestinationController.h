//
//  DestinationController.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileModel.h"
#import "TestLevelView.h"

@interface DestinationController : NSObject

-(instancetype)initWithCollectionView:(UICollectionView* ) collectionView;

//Takes the dragged tile from view controller and adds it to the collection view
-(void)addModel:(TileModel*)model;

-(void)clearInput;


@end
