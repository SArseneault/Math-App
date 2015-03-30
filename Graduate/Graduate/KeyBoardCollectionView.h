//
//  KeyBoardCollectionView.h
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "TileModel.h"

@interface KeyBoardCollectionView : NSObject

//pass reference to uicollectionview and parent viewcontorller to say a cell has been selected
- (instancetype)initWithCollectionView:(UICollectionView *)view andParentViewController:(ViewController *)parent;

//call to source when a cell has been dropped so it can re populate

- (void)tileDragCompleteWithModel:(TileModel *)model withValidDropPoint:(BOOL)validDropPoint;


@end
