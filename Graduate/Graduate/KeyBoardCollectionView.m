//
//  KeyBoardCollectionView.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import "KeyBoardCollectionView.h"
#import "ViewController.h"
#import "TileCollectionCell.h"

@interface KeyBoardCollectionView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
    
    UICollectionView *_collectionView;
    ViewController *_parentController;
    NSMutableArray *_tileModels;
    TileModel *_selectedTile;
    
    
}
@end
@implementation KeyBoardCollectionView

//custom "self" method
- (instancetype)initWithCollectionView:(UICollectionView *)view andParentViewController:(ViewController *)parent {
    if (self = [super init]) {
        
        NSLog(@"cUSTOM");
        [self setUpTileModels];
        [self initCollectionView:view];
        [self setUpGestures];
        
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


- (void)initCollectionView:(UICollectionView *)view {
    
            NSLog(@"cUSTOM2");
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

//creates the actual tiles


- (void)setUpGestures {
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handlePress:)];
    longPressGesture.numberOfTouchesRequired = 1;
    longPressGesture.minimumPressDuration    = 0.1f;
    [_collectionView addGestureRecognizer:longPressGesture];
}

//tell view controller when it is pressed
- (void)handlePress:(UILongPressGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:_collectionView];
    
    NSLog(@"In handle");
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:point];
        
        if (indexPath != nil) {
            
            _selectedTile=[_tileModels objectAtIndex:indexPath.item];
            NSLog(@"In index");
            //_selectedModel = [_models objectAtIndex:indexPath.item];
            
            // calculate point in parent view
            point = [gesture locationInView:_parentController.view];
            
            //tell view controller cell has been selected
            [_parentController setSelectedTile:_selectedTile atPoint:point];
            
            //Dim Cell when index is clicked
            [_collectionView cellForItemAtIndexPath:indexPath].alpha =0.2f;

            
        }
    }
    
    
}

#pragma mark - sent when tile is in input box from view controller
- (void)tileDragCompleteWithModel:(TileModel *)model withValidDropPoint:(BOOL)validDropPoint{
    
    NSLog(@"HEYYYYY");
    
    //Get what tile it is
    NSUInteger index =[_tileModels indexOfObject:model];
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    //if it is a valid point drop reload the keys
    if(validDropPoint && indexPath !=nil)
    {
     //reload collection keyboard
        [_collectionView reloadData];
        
    }
    //snap back or something i think here
    else{
        //not valid drop so reset cell
        NSLog(@"reset drop");
        UICollectionViewCell *initialCell = [_collectionView cellForItemAtIndexPath:indexPath];
        initialCell.alpha =1.0f;
        
    }
    
    
}



@end
