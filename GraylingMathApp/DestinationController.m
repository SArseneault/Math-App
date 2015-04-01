//
//  DestinationController.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 4/1/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "DestinationController.h"
#import "TileCollectionCell.h"
#import "TileModel.h"

@interface DestinationController()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
    //Array to store models entered into input box
    NSMutableArray *_models;
    UICollectionView *_collectionView;
    
    
}

@end


@implementation DestinationController
-(instancetype)initWithCollectionView:(UICollectionView* ) collectionView{
    
    if(self = [super init]){
        
        _models = [NSMutableArray array];
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //Set up tile from tileCollection Cell
        [_collectionView registerClass:[TileCollectionCell class] forCellWithReuseIdentifier:@"InputTileCell"];
        
    }
    return self;
}

//add objects to model array to populate collection view and reload view
-(void)addModel:(TileModel *)model{
    
    NSLog(@"recived added tile");
    
    [_models addObject:model];
    
    [_collectionView reloadData];
    
}

-(void)clearInput
{
    
    NSLog(@"Clearing input");
    [self->_models removeAllObjects];
    
    [_collectionView reloadData];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"Number of items in section %d", _models.count);
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TileCollectionCell *tile =(TileCollectionCell*) [_collectionView dequeueReusableCellWithReuseIdentifier:@"InputTileCell" forIndexPath:indexPath];
    
    TileModel *model = [_models objectAtIndex:indexPath.item];
    
    tile.model =model;
    
    return tile;
    
}

@end
