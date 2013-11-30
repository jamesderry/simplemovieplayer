//
//  ViewController.m
//  iOS3Lab6x
//
//  Created by James Derry on 11/25/13.
//  Copyright (c) 2013 James Derry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGRect screenrect;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // place in viewdidload method
     screenrect = [[UIScreen mainScreen] bounds];
     NSDictionary *boundsDict = [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithFloat:screenrect.origin.x], @"x",
     [NSNumber numberWithFloat:screenrect.origin.y], @"y",
     [NSNumber numberWithFloat:screenrect.size.width], @"width",
     [NSNumber numberWithFloat:screenrect.size.height], @"height", nil];
     NSLog(@"screen bounds = %@", boundsDict);
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sintelOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sintel_trailer-1080p" ofType:@"mp4"];
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    self.mplayer = [[MPMoviePlayerController alloc] initWithContentURL:fileUrl];
    
    self.mplayer.view.frame = self.view.bounds;
    self.mplayer.controlStyle = MPMovieControlStyleEmbedded;
    
    [self.view addSubview:self.mplayer.view];
    [self.mplayer play];

}

- (void)sintelOrientationChanged:(NSNotification *)notification
{
    NSLog(@"orientation changed...");
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    
    self.mplayer.view.transform = CGAffineTransformIdentity; //reset to normal top up state
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"landscape left");
        self.mplayer.view.frame = CGRectMake(0, 0, screenrect.size.height, screenrect.size.width);
        
    } else if (deviceOrientation == UIDeviceOrientationLandscapeRight) {
        NSLog(@"landscape right");
        self.mplayer.view.frame = CGRectMake(0, 0, screenrect.size.height, screenrect.size.width);
        
    } else if (deviceOrientation == UIDeviceOrientationPortrait) {
        NSLog(@"portrait");
        self.mplayer.view.frame = CGRectMake(0, 0, screenrect.size.width, screenrect.size.height);
        
    } /* else if (deviceOrientation == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"upside down");
        
        [UIView animateWithDuration:2.0f animations:^{
            self.mplayer.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } completion:^(BOOL finished) {
            self.mplayer.view.frame = CGRectMake(0, 0, screenrect.size.height, screenrect.size.width);
        }];
    } */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
