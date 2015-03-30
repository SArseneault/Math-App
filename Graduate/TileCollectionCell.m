//
//  TileCollectionCell.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
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

#pragma mark - make sure TileUiView is within bounds of collection view cell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tileUiView.frame = self.bounds;
}




@end
