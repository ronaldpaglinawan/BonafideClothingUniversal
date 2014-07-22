//
//  WebSiteViewController.h
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface WebSiteViewController : UIViewController
{
    NSTimer *timey;
}

@property (weak, nonatomic) IBOutlet UIWebView *webSiteView;


@property (strong, nonatomic) NSString *webString;
@property (strong, nonatomic) NSString *navTitle;


@end
