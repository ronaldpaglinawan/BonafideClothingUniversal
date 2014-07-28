//
//  DetailViewController.h
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import "AnnotationClass.h"
#import "SlideShow.h"
#import "promoIpadInfoViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, MFMailComposeViewControllerDelegate, SlideShowDelegate>
{
    // Declaration of Public Class Members or Instance Variables:
    NSArray *promoTitleArray;
    NSArray *promoDetailsArray;
    NSTimer *timey;
}



@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet SlideShow *slideshow;

@property (strong, nonatomic) promoIpadInfoViewController *promoInfoView;
@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
+ (CGFloat)annotationPadding;

// Actions
- (IBAction)showFacebook:(id)sender;
- (IBAction)showTwitter:(id)sender;
- (IBAction)showInstagram:(id)sender;
- (IBAction)showTumblr:(id)sender;
- (IBAction)composeEmail:(id)sender;
- (IBAction)stopSlideShow:(id)sender;
@end
