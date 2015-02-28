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

@end

