//
//  SideBarWebViewController.m
//  BonafideClothingUniversal
//
//  Created by Bonafide Infotech Inc. on 7/21/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "SideBarWebViewController.h"
#import "SWRevealViewController.h"

@interface SideBarWebViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
