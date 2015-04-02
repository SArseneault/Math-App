//
//  TileUiView.h
//  GraylingMathApp
//
//  Created by Kelly Markaity on 3/30/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

//Class is responsible for createing tiles that are UIViews for drag and drop keyboard

#import <UIKit/UIKit.h>

@interface TileUiView : UIView

@property (nonatomic, strong) UILabel *label; //Lable for tile

-(void)setHighLight:(BOOL)highLight; //highlight tiles

-(void)setOutHighLight:(BOOL)highLight;


@end
