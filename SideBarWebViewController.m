//
//  SideBarWebViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/21/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "SideBarWebViewController.h"
#import "SWRevealViewController.h"

@interface SideBarWebViewController ()
{
    UIActivityIndicatorView *progressIndicator;
}
@end

@implementation SideBarWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change the color of Sidebar
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it will show up the sidebar
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    
    [_webView reload];
    NSLog(@"sideBarWebString: %@", _sideBarWebString);
    
    // load the website url
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_sideBarWebString]]];
    
    // initialize the activity indicator
    progressIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *itemIndicator = [[UIBarButtonItem alloc] initWithCustomView:progressIndicator];
    [self.navigationItem setRightBarButtonItem:itemIndicator];
    [progressIndicator startAnimating];
    
    // set the timer
    timey = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:Nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loading
{
    if (!_webView.loading)
    {
        [progressIndicator stopAnimating];
    }
    
    else
    {
        [progressIndicator startAnimating];
    }
}

@end
