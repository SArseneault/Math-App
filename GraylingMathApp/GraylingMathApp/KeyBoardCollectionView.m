//
//  KeyBoardCollectionView.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "KeyBoardCollectionView.h"
#import "TestLevelView.h"
#import "TileCollectionCell.h"

@interface KeyBoardCollectionView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    TestLevelView *_parentController;
    NSMutableArray *_tileModels;
    
}

@end

@implementation KeyBoardCollectionView

- (instancetype)initWithCollectionView:(UICollectionView *)view andParentViewController:(TestLevelView *)parent{
    if (self = [super init]) {
        
        NSLog(@"cUSTOM");
        [self setUpTileModels];
        [self initCollectionView:view];
        //[self setUpGestures];
        
        _parentController = parent;
    }
    
    
    return self;
}

#pragma mark- set up tile models
-(void) setUpTileModels{
    
    _tileModels = [NSMutableArray array];
    for (int i=0; i <10; i++)
    {
        [_tileModels addObject:[[TileModel alloc]initWithValue:i]];
        
    }
    
}

//Set up actual tiles in the collection view
- (void)initCollectionView:(UICollectionView *)view {
    
    NSLog(@"KeyboardCollectionView initCollectionView view");
    _collectionView            = view;
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    
    //Set up tile from tileCollection Cell
    [_collectionView registerClass:[TileCollectionCell class] forCellWithReuseIdentifier:@"TileCell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //UICollectionViewCell *tile = [collectionView dequeueReusableCellWithReuseIdentifier:@"TileCell" forIndexPath:indexPath];
    
    TileCollectionCell *tile = [_collectionView dequeueReusableCellWithReuseIdentifier:@"TileCell" forIndexPath:indexPath];
    
    tile.backgroundColor = [UIColor blackColor];
    return tile;
}

#pragma mark - collection view data source


////returns the number of items to display in a certian section
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}
//
////number of sections
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

@end
