//
//  SplashScreenViewController.h
//  BonafideClothing
//
//  Created by Pauline Milan on 7/9/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController
{
    NSTimer *myTimer;
}

// Imageview for Splash Screen
@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;

// Array for Splash Screen Images
@property (strong, nonatomic) NSArray *splashScreenImages;

@end
