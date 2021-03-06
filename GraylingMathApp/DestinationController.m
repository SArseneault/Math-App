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
#import "TestLevelView.h"

@interface DestinationController()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    
    //Array to store models entered into input box
    NSMutableArray *_models;
    UICollectionView *_collectionView;
    TestLevelView *_parentController;
    TileModel *_selectedInputTile;
    
    //Create array to store numbers inputed from dragged tiles
    NSMutableArray *_userInputArray;
    

    
    
}

@end


@implementation DestinationController
-(instancetype)initWithCollectionView:(UICollectionView* ) collectionView andParentViewController:(TestLevelView *)parent{
    
    if(self = [super init]){
        
        _models = [NSMutableArray array];
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //Set up tile from tileCollection Cell
        [_collectionView registerClass:[TileCollectionCell class] forCellWithReuseIdentifier:@"InputTileCell"];
        
        //set up gestures
        [self setUpInputGesture];
        
        //Set up tile models
        //[self setupInputTiles];
        
        _parentController = parent;
        
        //Set up array to store tile input
        _userInputArray=[[NSMutableArray alloc]init];
        
    }
    return self;
}

//set up gestures for input controller
-(void) setUpInputGesture{
    
    NSLog(@"Setting Up Gestures INPUT BOX");
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handlePress:)];
    longPressGesture.numberOfTouchesRequired = 1;
    longPressGesture.minimumPressDuration    = 0.01f;
    [_collectionView addGestureRecognizer:longPressGesture];
    
    
    
}

- (void)handlePress:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"GOT HANDLE pRESS IN INPUT");
    
    CGPoint point = [gesture locationInView:_collectionView];
    
    if (gesture.state ==UIGestureRecognizerStateBegan){
        
        NSLog(@"Gesture state started INPUTTT");
        
    
    NSIndexPath *indexPath =[_collectionView indexPathForItemAtPoint:point];
        
        if(indexPath !=nil)
        {
            NSLog(@"Index path not nil");
            NSLog(@"Index path is %@", indexPath);
            _selectedInputTile=[_models objectAtIndex:indexPath.item];
            
            NSLog(@"DIMMINING");
            
            //find the point in the parent view
            point =[gesture locationInView:_parentController.view];
            
            //tell the parent which tile is selected
            [_parentController setSelectedInputTile:_selectedInputTile atPoint:point];
            
            
            [_collectionView cellForItemAtIndexPath:indexPath].alpha =0.2f;
            
            
        }
        else{
            
            NSLog(@"Index path nil");
        }
        
    }

    
    
    
}
//add objects to model array to populate collection view and reload view
-(void)addModel:(TileModel *)model{
    
    NSLog(@"recived added tile");
    
    NSLog(@"Tile dropeeeeeee is %@", model);
    
    NSLog(@"Tile dropeeeeeee value is %d", model.value);
    
    
    
    int insertNumber = model.value;
    
    [_userInputArray addObject:[NSNumber numberWithInt:insertNumber]];
    
    //[self AddInputToArray:(int)model.value];
    
    
     NSLog(@"Size is beforeeeee   %d", [_userInputArray count]);
    NSLog(@"Added thissssss %i", insertNumber);
     [_models addObject:model];
    //NSLog(@"modelllllllll %i", _models.value);
    NSLog(@"PRINTING MODELSS %lu", (unsigned long)[_models count]);
    
    [_collectionView reloadData];
    
        NSLog(@"Size is afterreeeee  %d", [_userInputArray count]);
    
}

-(void)AddInputToArray:(int)input{
    
    NSLog(@"Number recived!!!!!!!!!!!!!!! is %d", input);
    

    
    
    
}

//remove tile from input

-(void)removeTile:(TileModel *)model
{
    
    NSLog(@"REMOVING");
    NSInteger index = [_models indexOfObject:model];
    NSIndexPath *indexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    NSInteger size = [_userInputArray count];
    
    NSLog(@"Size is of array in remove is _______________________%d", size);
    
    NSLog(@"NSINT INDEX IS %d", index);
    NSLog(@"NSINT INDEXPATH IS %@", indexPath);
    
    int removeInt = model.value;
    NSLog(@"VALUEEE REMOVED %i", removeInt);
    
    [_userInputArray removeObject:[NSNumber numberWithInt:index]];
    
    NSLog(@"Tile removed is %d", model.value);
    
    [_models removeObjectAtIndex:index];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [_collectionView reloadData];

    
    
    
}
-(NSInteger)getValue{
    
    
    NSInteger size = [_models count];
    
    NSLog(@"Size of model is %i", size);
    
    if(size ==0)
    {
        
        return 0;
    }
    else if (size >1)
    {
        TileModel *firstModel =[_models objectAtIndex:0];
        TileModel *secondModel =[_models objectAtIndex:1];
        NSInteger firstValue = firstModel.value;
        NSInteger secondValue = secondModel.value;
        
        return (firstValue*10)+secondValue;
        
        
    }
    else
    {
        TileModel *firstModel =[_models objectAtIndex:0];
        NSInteger finalV= firstModel.value;
        
        return finalV;
    }
    

}
-(void)clearInput
{
    
    NSLog(@"Clearing input");
    [self->_models removeAllObjects];
    
    [_collectionView reloadData];
    
    
    //remove everything from array
    [_userInputArray removeAllObjects];
    
    
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
