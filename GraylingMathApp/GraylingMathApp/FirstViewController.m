//
//  FirstViewController.m
//  PirateMathApplication
//
//  Created by Samuel Arseneault on 2/9/15.
//  Copyright (c) 2015 Samuel Arseneault. All rights reserved.
//

#import "FirstViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "baseURL.h"

@interface FirstViewController (){
    AVAudioPlayer *_audioPlayer;
    bool playSwitch;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Contrsut URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/carHorn.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    //Create audio player object and initalize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    //Establish connection
    
    NSString *strURL = [baseURL stringByAppendingString:[NSString stringWithFormat:@"logclassin.php?userName=%@&password=%@", @"test", @"password"]];
    strURL = [strURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"%@",strURL);

    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    NSLog(@"%@",dataURL);

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


@end
