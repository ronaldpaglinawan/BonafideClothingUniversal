//
//  SplashScreenViewController.m
//  BonafideClothing
//
//  Created by Pauline Milan on 7/9/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set the status bar to light color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Load Splash Screen Images
    _splashScreenImages = @[@"splash_1.png", @"splash_2.png", @"splash_3.png", @"splash_4.png"];
    
    [self countDown];
    
    
}

- (void)changeImage
{
    
    static int ctr = 0;
    
    if (ctr == 4)
    {
        [myTimer invalidate];
        
        [self performSegueWithIdentifier:@"homeModal" sender:self];
    }
    
    else
    {
        self.splashImageView.image = [UIImage imageNamed:[_splashScreenImages objectAtIndex:ctr]];
        ctr++;
    }
    
    NSLog(@"Image %i Done!", ctr);
}

- (void)countDown
{
    // Timer
    NSLog(@"countDown method");
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}



@end
