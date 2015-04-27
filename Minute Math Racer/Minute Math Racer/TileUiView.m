//
//  TileUiView.m
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "TileUiView.h"

@implementation TileUiView

//set up uiview for tile set font, alignment etc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label               = [[UILabel alloc] init];
        self.label.font          = [UIFont boldSystemFontOfSize:86];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor =[UIColor colorWithRed:255/255.0f green:0/255.0f blue:4/255.0f alpha:1.0f];
        [self addSubview:self.label];
        
        self.backgroundColor    = [UIColor colorWithRed:201/255.0f green:201/255.0f blue:201/255.0f alpha:1.0f];
        self.layer.cornerRadius = 10.0f;
    }
    return self;
}

//Highlight tile when it is in the approrpiate box
-(void)setHighLight:(BOOL)highlight{
    
    if(highlight)
    {
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 5.0f;
    }
    else
    {
        self.layer.borderWidth = 0.0f;
    }
}

-(void)setOutHighLight:(BOOL)highlight{
    
    if(highlight)
    {
        self.layer.borderColor = [UIColor redColor].CGColor;
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
