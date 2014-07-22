//
//  WebSiteViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "WebSiteViewController.h"

@interface WebSiteViewController ()
{
    UIActivityIndicatorView *progressIndicator;
}
@end

@implementation WebSiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webSiteView reload];
    
    NSLog(@"navtitle: %@", _navTitle);
    NSLog(@"webstring: %@", _webString);
    
    // set the navigation bar attributes
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
   //self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    
    // set navigation title text
    self.navigationItem.title = _navTitle;
    
    // load the website url
    [_webSiteView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webString]]];

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
    if (!_webSiteView.loading)
    {
        [progressIndicator stopAnimating];
    }
    
    else
    {
        [progressIndicator startAnimating];
    }
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
