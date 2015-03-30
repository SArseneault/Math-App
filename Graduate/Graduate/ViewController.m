//
//  ViewController.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardCollectionView.h"
#import "TileUiView.h"
#import "TileModel.h"
#import "inputController.h"

@interface ViewController () <UIGestureRecognizerDelegate>
{
    KeyBoardCollectionView *_keyBoardCollectionView;
    
    //creates a dragged tile
    TileUiView *_draggedTile;
    
    //data for tiles
    TileModel *_tileModel;
    
    //uiview for tiles
    inputController *_inputController;
    
}

//collection view for keyboard
@property (weak, nonatomic) IBOutlet UICollectionView *keyBoard;

@property (weak, nonatomic) IBOutlet UIView *inputArea;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
    
    //creates actual keyboard layout
    NSLog(@"cREATING KEYBOARD");
    _keyBoardCollectionView = [[KeyBoardCollectionView alloc]initWithCollectionView:self.keyBoard andParentViewController:self];
    
    //create input controller
    _inputController=[[inputController alloc] initWithUIView:self.inputArea andParentViewController:self];
    
    
    [self initDraggedTileView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    
}

#pragma mark - recived tile call from keyboard collection
-(void)setSelectedTile:(TileModel*)tileModel atPoint:(CGPoint)point{
    _tileModel=tileModel;

    NSLog(@"Recived tile call");
    if(_tileModel !=nil)
    {
            NSLog(@"Making tile visible");
        _draggedTile.label.text=[NSString stringWithFormat:@"%d",tileModel.value];
        _draggedTile.center=point;
        _draggedTile.hidden=NO;
        
        //call to update dragged state and if it is a valid drag point
        [self updateTileViewDragState:[self isValidDragPoint:point]];
    }

    
    
}

#pragma mark - for the actual drag point
//returns true when tile is over input area

-(BOOL)isValidDragPoint:(CGPoint)point{
    
    NSLog(@"is valid bool");
   
    return CGRectContainsPoint(self.inputArea.frame,point);
}
#pragma mark - initilize dragged tile

-(void) initDraggedTileView{
    
        NSLog(@"Dragg ");
    _draggedTile =[[TileUiView alloc]initWithFrame:CGRectMake(0,0,120,140)];
    _draggedTile.hidden =YES;
    
    //[_draggedTile setHighLight:YES];
    
    [self.view addSubview:_draggedTile];
    
    
}

#pragma mark- valid place to drag
-(void)updateTileViewDragState:(BOOL)validDropPoint{
    
    if(validDropPoint){
       [ _draggedTile setHighLight:YES];
       // _draggedTile.alpha=1.0f;
    }
    else{
        
               [ _draggedTile setHighLight:NO];
       // _draggedTile.alpha=0.2f;
    }
    
    
}


#pragma mark- dragged tile view



//gesture recgonizer for parent view controller

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    NSLog(@"In hadle pan of view controller")
    ;
    CGPoint touchPoint =[gesture locationInView:self.view];
    
    //calls when tile is moving
    if(gesture.state==UIGestureRecognizerStateChanged && !_draggedTile.hidden)
    {
            NSLog(@"Drag recgonizer");
        //tile is dragged
        _draggedTile.center=touchPoint;
        
        //update where card is
        [self updateTileViewDragState:[self isValidDragPoint:touchPoint]];
    }
    else if (gesture.state ==UIGestureRecognizerStateRecognized && _tileModel!=nil){
        
        _draggedTile.hidden=YES;
        
        BOOL validDropPoint =[self isValidDragPoint:touchPoint];
        
        if(validDropPoint)
        {
            //tell keyboard and input that it is updated
            [_keyBoardCollectionView tileDragCompleteWithModel:(TileModel *)_tileModel withValidDropPoint:(BOOL)validDropPoint];
            
            //tell input
            [_inputController addTile:_tileModel];
            NSLog(@"Can drop");
        }
        else{
            //tell keyboard and input that it is updated
            [_keyBoardCollectionView tileDragCompleteWithModel:(TileModel *)_tileModel withValidDropPoint:(BOOL)validDropPoint];
                    NSLog(@"Cant Drop");
            
        }




    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
