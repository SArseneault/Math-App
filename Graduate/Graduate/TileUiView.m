//
//  TileUiView.m
//  Graduate
//
//  Created by Kelly Markaity on 3/27/15.
//  Copyright (c) 2015 Kelly Markaity. All rights reserved.
//

#import "TileUiView.h"

@implementation TileUiView


//set up uiview for tile set font, alignment etc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label               = [[UILabel alloc] init];
        self.label.font          = [UIFont boldSystemFontOfSize:48];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.backgroundColor    = [UIColor whiteColor];
        self.layer.cornerRadius = 10.0f;
    }
    return self;
}

//Highlight tile when it is in the approrpiate box
-(void)setHighLight:(BOOL)highlight{
    
    if(highlight)
    {
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 5.0f;
    }
    else
    {
        self.layer.borderWidth = 0.0f;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}

@end
