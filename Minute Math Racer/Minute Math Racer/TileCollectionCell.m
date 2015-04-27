//
//  TileCollectionCell.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "TileCollectionCell.h"
#import "TileUiView.h"

@interface TileCollectionCell(){
    TileUiView *_tileUiView;
    
}

@end

@implementation TileCollectionCell

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self)
    {
        _tileUiView =[[TileUiView alloc]init];
        [self.contentView addSubview:_tileUiView];
    }
    return self;
}

#pragma mark - set the tile value and label
-(void)setModel:(TileModel *)model{
    
    _model =model;
    
    _tileUiView.label.text =[NSString stringWithFormat:@"%d", _model.value];
}

#pragma mark - make sure TileUiView is within bounds of collection view cell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tileUiView.frame = self.bounds;
}

@end
