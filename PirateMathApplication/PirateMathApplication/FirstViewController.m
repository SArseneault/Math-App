//
//  FirstViewController.m
//  PirateMathApplication
//
//  Created by Samuel Arseneault on 2/9/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController ()
{
    AVAudioPlayer *_audioPlayer;
    bool playSwitch;
}

@property (nonatomic, weak) IBOutlet UIImageView *zeroTileView;
@property (nonatomic, weak) UIView *TileReset;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Contrsut URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/sailor_s_piccolo.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    //Create audio player object and initalize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toggleSound:(id)sender {
    
    // Play sound when button is clicked
    if(!playSwitch){
        [_audioPlayer play];
        playSwitch = true;
    }
    else{
        [_audioPlayer stop];
        playSwitch = false;
    }
}

<<<<<<< HEAD
=======
<<<<<<< HEAD
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

-(IBAction
   )showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        self.TileReset = [gestureRecognizer view];
        
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


- (void)resetPiece:(UIMenuController *)controller
{
    UIView *TileReset = self.TileReset;
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(TileReset.bounds), CGRectGetMidY(TileReset.bounds));
    CGPoint locationInSuperview = [TileReset convertPoint:centerPoint toView:[TileReset superview]];
    
    [[TileReset layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    [TileReset setCenter:locationInSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [TileReset setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark - Touch handling

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



=======

-(IBAction)calculate{
    
    float x = ([textFeild1.text floatValue]);
    float c = x+([textFeild2.text floatValue]);
    
    label.text = [[NSString alloc] initWithFormat:@"%2.f",c];
    
    
}

-(IBAction)clear{
    
    textFeild1.text =@"";
    textFeild2.text =@"";
    label.text = @"";
    
}
>>>>>>> 78fe2a3d71237b088338a1b061c4026cfbe971c7
>>>>>>> 4277288ef70dd93654f321cab87ea2f4f09e8858
@end

