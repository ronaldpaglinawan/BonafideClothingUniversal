//
//  HomeViewController.h
//  BonafideClothing
//
//  Created by Pauline Milan on 7/10/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SlideShow.h"
#import "WebSiteViewController.h"



@class PromoInfoView;

@interface HomeViewController : UIViewController <SlideShowDelegate, MFMailComposeViewControllerDelegate>
{
    // Declaration of Public Class Members or Instance Variables:
    NSArray *promoTitleArray;
    NSArray *promoDetailsArray;
}

// ---- Declaration of Outlets & Data Properties:

// List of Outlets (ex. IBOutlet):
@property (strong, nonatomic) IBOutlet PromoInfoView *promoInfoView;
@property (strong, nonatomic) IBOutlet SlideShow *slideshow;
@property (strong, nonatomic) IBOutlet UILabel *promoTitleLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *arrivalButton;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;
@property (weak, nonatomic) IBOutlet UIButton *mensButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;


// List of Data Properties (ex. NSStrings, etc):




// ---- Declaration of Actions, Protocol Methods, & Custom Methods:

// List of Actions:
- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)instagramButtonPressed:(id)sender;
- (IBAction)tumblrButtonPressed:(id)sender;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)composeEmail:(id)sender;
- (IBAction)closeButtonPressed:(id)sender;
- (IBAction)SlideShowStopButtonClicked:(id)sender;


// List of Protocol Methods (required datasource and delegate methods):



// List of Custom Methods:




@end
