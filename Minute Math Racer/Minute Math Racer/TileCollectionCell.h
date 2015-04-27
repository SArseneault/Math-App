//
//  TileCollectionCell.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

//Creates the actuall tiles in the uicollection view

#import <UIKit/UIKit.h>
#import "TileModel.h"

@interface TileCollectionCell : UICollectionViewCell

@property (nonatomic, strong) TileModel *model;

@end
