//
//  TileView.m
//  PirateMathApplication
//
//  Created by John Luu on 2/26/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileView.h"
#import <QuartzCore/QuartzCore.h>

@interface TileView()

// Views the user can move. Currently has no value and is is movable images

@property (nonatomic, weak) IBOutlet UIImageView *zeroTile;
@property (weak, nonatomic) IBOutlet UIImageView *oneTile;
@property (weak, nonatomic) IBOutlet UIImageView *twoTile;

//not quite implemented to reset yet
@property (nonatomic, weak) UIView *tileForReset;

@end


@implementation TileView


#pragma mark - Utility methods

/**
 Scale and rotation transforms are applied relative to the layer's anchor point this method moves a gesture recognizer's view's anchor point between the user's fingers. 
 This anchor point has not been implemented yet. It is suppose create an anchor point for the tiles to reset to
 */
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


/**
 A gesture recognizer that enables the application to recognize a finger pressing down on an object
 */
-(IBAction)showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        self.tileForReset = [gestureRecognizer view];
        
        /*
         Set up the reset menu.
         */
        NSString *menuItemTitle = NSLocalizedString(@"Reset", @"Reset menu item title");
        UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:menuItemTitle action:@selector(resetPiece:)];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setMenuItems:@[resetMenuItem]];
        
        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
        CGRect menuLocation = CGRectMake(location.x, location.y, 0, 0);
        [menuController setTargetRect:menuLocation inView:[gestureRecognizer view]];
        
        [menuController setMenuVisible:YES animated:YES];
    }
}


/**
 Animate back to the default anchor point and transform.
 */
- (void)resetPiece:(UIMenuController *)controller
{
    UIView *tileForReset = self.tileForReset;
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(tileForReset.bounds), CGRectGetMidY(tileForReset.bounds));
    CGPoint locationInSuperview = [tileForReset convertPoint:centerPoint toView:[tileForReset superview]];
    
    [[tileForReset layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    [tileForReset setCenter:locationInSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [tileForReset setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}


// UIMenuController requires that we can become first responder or it won't display
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark - Touch handling

/**
 This Gesture recognizer allows the the user to "drag" the object pieces around 
 */
- (IBAction)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}



/**
 Ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously.
 Prevent other gesture recognizers from recognizing simultaneously.This is suppose to be able to recognize if multiple objects are being touched and how to handle it
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // If the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition.
    if (gestureRecognizer.view != self.zeroTile && self.oneTile && self.twoTile) {
        return NO;
    }
    
    // If the gesture recognizers are on different views, don't allow simultaneous recognition.
    if (gestureRecognizer.view != otherGestureRecognizer.view) {
        return NO;
    }
    
    // If either of the gesture recognizers is the long press, don't allow simultaneous recognition.
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    
    return YES;
}


@end
