//
//  DetailViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "DetailViewController.h"

static int kMapIndex = 0;

@interface DetailViewController ()
{
    UIActivityIndicatorView *progressIndicator;
    NSString *detailName;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // set detailName to name value in detailItem
    detailName = [self.detailItem objectForKey:@"name"];
    NSLog(@"detailName: %@", detailName);
    
    
    if (self.detailItem)
    {
        if (detailName == NULL)
        {
            // show imageView
            _imageView.hidden = NO;
            
            // show backgroundImageView
            _backgroundImageView.hidden = NO;
            
            // hide webView
            _webView.hidden = YES;
            
            // hide mapView
            _mapView.hidden = YES;
            
            // show slideShow
            _slideshow.hidden = NO;
            
            // set navigation bar title
            self.navigationItem.title = @"BONAFIDE CLOTHING";
        }
        
        else if ([detailName isEqualToString:@"HOME"])
        {
            // show imageView
            _imageView.hidden = NO;
            
            // show backgroundImageView
            _backgroundImageView.hidden = NO;
            
            // hide webView
            _webView.hidden = YES;
            
            // hide mapView
            _mapView.hidden = YES;
            
            // show slideShow
            _slideshow.hidden = NO;
            
            // set navigation bar title
            self.navigationItem.title = @"BONAFIDE CLOTHING";
        }
        
        else if (![detailName isEqualToString:@"STORE LOCATOR"])
        {
            // hide imageView
            _imageView.hidden = YES;
            
            // hide backgroundImageView
            _backgroundImageView.hidden = YES;
            
            // show webView
            _webView.hidden = NO;
            
            // hide mapView
            _mapView.hidden = YES;
            
            // hide slideShow
            _slideshow.hidden = YES;
            
            
            NSURL *detailURL;
            detailURL=[[NSURL alloc] initWithString:
                       [self.detailItem objectForKey:@"url"]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:detailURL]];
            self.navigationItem.title = [self.detailItem objectForKey:@"name"];
        }
        
        else
        {
            
            // set the map properties
            [_mapView setMapType:MKMapTypeStandard];
            [_mapView setZoomEnabled:YES];
            [_mapView setScrollEnabled:YES];
            
            MKCoordinateRegion region = { {0.0, 0.0} , {0.0, 0.0 } };
            region.center.latitude = -33.877881;  // The location is Shop 4 / 27-33 Goulburn St. Sydney NSW 2000, Australia
            region.center.longitude = 151.205138;
            region.span.longitudeDelta = 0.001f;
            region.span.latitudeDelta = 0.001f;
            [_mapView setRegion:region animated:YES];
            
            
            
            // add annotations in the map
            self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
            
            AnnotationClass *MapAnnotation = [[AnnotationClass alloc] init];
            [self.mapAnnotations insertObject:MapAnnotation atIndex:kMapIndex];
            
            MapAnnotation.title = @"Bonafide Store";
            MapAnnotation.subtitle = @"Shop 4 / 27-33 Goulburn St. Sydney NSW 2000";
            MapAnnotation.coordinate = region.center;
            
            [_mapView addAnnotation:[self.mapAnnotations objectAtIndex:kMapIndex]];
            
            
            // hide imageView
            _imageView.hidden = YES;
            
            // hide backgroundImageView
            _backgroundImageView.hidden = YES;
            
            // hide webView
            _webView.hidden = YES;
            
            // show mapView
            _mapView.hidden = NO;
            
            // hide slideShow
            _slideshow.hidden = YES;
            
            
            // set navigation bar title
            self.navigationItem.title = [self.detailItem objectForKey:@"name"];
        }
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    
    // set the status bar to light color
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // initialize the activity indicator
    progressIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *itemIndicator = [[UIBarButtonItem alloc] initWithCustomView:progressIndicator];
    [self.navigationItem setRightBarButtonItem:itemIndicator];
    [progressIndicator startAnimating];
    
    // set the timer
    timey = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:Nil repeats:YES];
    
    // hide webView
    _webView.hidden = YES;
    
    // hide mapView
    _mapView.hidden = YES;
    
    // set imageView
    _imageView.image = [UIImage imageNamed:@"bonafideLogoWhite"];
    
    // set backgroundImageView
    _backgroundImageView.image = [UIImage imageNamed:@"bonafideClothingBackground"];
    
    
    // initialize the slide show
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:.5]; // Transition duration
    [_slideshow setTransitionType:SlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:@[@"iPadPromo1",@"iPadPromo2",@"iPadPromo3"]]; // Add images from resources
    
    
    //set transition
    [_slideshow setTransitionType:SlideShowTransitionFade];
    
    //start
    [_slideshow start];
    
    
    // set static data of promoTitleArray
    promoTitleArray = @[@"Promo Title 1", @"Promo Title 2", @"Promo Title 3"];
    
    // set static data of promoDetailsArray
    promoDetailsArray = @[
                          @"Here are the details for the Promo 1. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.",
                          @"Here are the details for the Promo 2. Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are?",
                          @"Here are the details for the Promo 3. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch."];

    
    [self configureView];
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

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}

- (IBAction)stopSlideShow:(id)sender
{
    // pause slide show
    // [_slideshow stop];
        
    // set promoInfoView's chosenTitle & chosenDescription to current title & description
    _promoInfoView.chosenTitle = promoTitleArray[_slideshow.currentIndex];
    _promoInfoView.chosenDescription = promoDetailsArray[_slideshow.currentIndex];
    
    
}

- (IBAction)showFacebook:(id)sender
{
    // show webView
    _webView.hidden = NO;
    
    // hide mapView
    _mapView.hidden = YES;
    
    // hide imageView
    _imageView.hidden = YES;
    
    // hide backgroundImageView
    _backgroundImageView.hidden = YES;
    
    // hide slideShow
    _slideshow.hidden = YES;
    
    // set title in navigation bar
    self.navigationItem.title = @"Facebook";
    
    // load url on webView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.facebook.com/bonafidestore"]]];
}

- (IBAction)showTwitter:(id)sender
{
    // show webView
    _webView.hidden = NO;
    
    // hide mapView
    _mapView.hidden = YES;
    
    // hide imageView
    _imageView.hidden = YES;
    
    // hide backgroundImageView
    _backgroundImageView.hidden = YES;
    
    // hide slideShow
    _slideshow.hidden = YES;
    
    // set title in navigation bar
    self.navigationItem.title = @"Twitter";

    
    // load url on webView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://twitter.com/bonafide_store"]]];
}

- (IBAction)showInstagram:(id)sender
{
    // show webView
    _webView.hidden = NO;
    
    // hide mapView
    _mapView.hidden = YES;
    
    // hide imageView
    _imageView.hidden = YES;
    
    // hide backgroundImageView
    _backgroundImageView.hidden = YES;
    
    // hide slideShow
    _slideshow.hidden = YES;
    
    // set title in navigation bar
    self.navigationItem.title = @"Instagram";
    
    // load url on webView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://instagram.com/bonafidestore"]]];
}

- (IBAction)showTumblr:(id)sender
{
    // show webView
    _webView.hidden = NO;
    
    // hide mapView
    _mapView.hidden = YES;
    
    // hide imageView
    _imageView.hidden = YES;
    
    // hide backgroundImageView
    _backgroundImageView.hidden = YES;
    
    // hide slideShow
    _slideshow.hidden = YES;
    
    // set title in navigation bar
    self.navigationItem.title = @"Tumblr";
    
    // load url on webView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bonafidestore.tumblr.com/"]]];
}

- (IBAction)composeEmail:(id)sender
{
    // open mail view
    if ([MFMailComposeViewController canSendMail])
    {
        
        //Set-up the mailView
        MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
        mailView.mailComposeDelegate = self;
        
        [mailView setSubject:@"Customer Inquiry"];
        [mailView setToRecipients:[NSArray arrayWithObject:@"info@bnfde.com"]]; //to recipients email address
        [mailView setMessageBody:@"" isHTML:NO]; // preset body message
        
        
        [self presentViewController:mailView animated:YES completion:nil];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}



#pragma mark - MFMailComposeViewControllerDelegates
- (void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
            
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[AnnotationClass class]])   // for Trinoma
    {
        
        static NSString *myIdentifier = @"myIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:myIdentifier];
        
        if (!pinView)
        {
            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:myIdentifier];
            annotationView.canShowCallout = YES;
            
            //UIImage *flagImage = [UIImage imageNamed:@"apple logo.png"];
            
            CGRect resizeRect;
            
            //resizeRect.size = flagImage.size;
            CGSize maxSize = CGRectInset(self.view.bounds,
                                         [DetailViewController annotationPadding],
                                         [DetailViewController annotationPadding]).size;
            
            
            if (resizeRect.size.width > maxSize.width)
                resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
            
            if (resizeRect.size.height > maxSize.height)
                resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
            
            resizeRect.origin = (CGPoint){0.0f, 0.0f};
            UIGraphicsBeginImageContext(resizeRect.size);
            //[flagImage drawInRect:resizeRect];
            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            annotationView.image = resizedImage;
            annotationView.opaque = NO;
            
            //UIImageView *IconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple logo.png"]];
            //annotationView.leftCalloutAccessoryView = IconView;
            
            return annotationView;
        }
        
        else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    
    return nil;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.image = [UIImage imageNamed:@"menu-01"];
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



#pragma mark - Navigation Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __FUNCTION__);  // temporary checker
    
    if ([segue.identifier isEqualToString:@"promoInfoSegue"])
    {
        _promoInfoView = segue.destinationViewController;
    }
    
}

@end
