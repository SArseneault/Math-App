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
    TileModel *_selectedTile;
    
}

@end

@implementation KeyBoardCollectionView

- (instancetype)initWithCollectionView:(UICollectionView *)view andParentViewController:(TestLevelView *)parent{
    if (self = [super init]) {
        
        [self setUpTileModels];//set up the actual tiles
        
        [self initCollectionView:view]; //set up collection view in the parent view
        
        [self setUpGestures]; //set up gestures
        
        _parentController = parent;
    }
    
    
    return self;
}

#pragma mark- Fill in tile once it is dropped
-(void)cellDragCompleteWithModel:(TileModel *)model{
    

    if(model !=nil)
    {
        NSInteger index =[_tileModels indexOfObject:model];
        NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:0];
        [_collectionView cellForItemAtIndexPath:indexPath].alpha=1.0f;
    }
}

#pragma mark- set up gestures to send to parent view

- (void)setUpGestures {
    

    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handlePress:)];
    longPressGesture.numberOfTouchesRequired = 1;
    longPressGesture.minimumPressDuration    = 0.01f;
    [_collectionView addGestureRecognizer:longPressGesture];
}


#pragma mark- hadle press function
- (void)handlePress:(UILongPressGestureRecognizer *)gesture {
    

    
    CGPoint point = [gesture locationInView:_collectionView];
    
    //Get the point in the collection view where gesture is recgonized
    if (gesture.state ==UIGestureRecognizerStateBegan){
        
        //get the point
        NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:point];
        
        //if point is on an index
        if(indexPath !=nil)
        {
            
            _selectedTile=[_tileModels objectAtIndex:indexPath.item];
            
            //Calculate point in parent view controller (Test Level View)
            point = [gesture locationInView:_parentController.view];
            
            //tell view controller cell has been selected
            [_parentController setSelectedTile:_selectedTile atPoint:point];
            
            //Dim the tile when it is being dragged in parent view
            //Dim Cell when index is clicked
            
            [_collectionView cellForItemAtIndexPath:indexPath].alpha =0.2f;
            
            
        }
        else
        {

            
        }
        
        
    }
    
    
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
    

    _collectionView            = view;
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    
    //Set up tile from tileCollection Cell
    [_collectionView registerClass:[TileCollectionCell class] forCellWithReuseIdentifier:@"TileCell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    
    TileCollectionCell *tile =(TileCollectionCell*) [_collectionView dequeueReusableCellWithReuseIdentifier:@"TileCell" forIndexPath:indexPath];
    
    TileModel *model = [_tileModels objectAtIndex:indexPath.item];
    
    //set label of tile
    [tile setModel:model];
    
    //tile.backgroundColor = [UIColor blackColor];
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
