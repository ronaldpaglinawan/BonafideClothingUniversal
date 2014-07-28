//
//  promoIpadInfoViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/24/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "promoIpadInfoViewController.h"

@interface promoIpadInfoViewController ()

@end

@implementation promoIpadInfoViewController

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
    
    [_promoIpadView.layer setCornerRadius:10.0f];
}


- (void)setChosenTitle:(NSString *)newChosenTitle
{
    if (_chosenTitle != newChosenTitle)
    {
        _chosenTitle = newChosenTitle;
        
        // Update the view.
        [self configureView];
    }
    
}

- (void)setChosenDescription:(NSString *)newChosenDescription
{
    if (_chosenDescription != newChosenDescription)
    {
        _chosenDescription = newChosenDescription;
        
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    // set initial values of titleLabel and detailsTextView
    _titleLabel.text = _chosenTitle;
    _detailTextView.text = _chosenDescription;
    
    NSLog(@"chosenTitle: %@", _chosenTitle);
    NSLog(@"chosenDescription: %@", _chosenDescription);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissPromoView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
