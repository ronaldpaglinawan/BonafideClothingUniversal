//
//  HomeViewController.m
//  BonafideClothing
//
//  Created by Pauline Milan on 7/10/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "SlideShow.h"
#import "PromoInfoView.h"
#import "SWRevealViewController.h"



@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    // set the navigation bar properties
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_image"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    
    // initialize the slide show
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:.5]; // Transition duration
    [_slideshow setTransitionType:SlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:@[@"iPhonePromo1",@"iPhonePromo2",@"iPhonePromo3"]]; // Add images from resources
    
    // set static data of promoTitleArray
    promoTitleArray = @[@"Promo Title 1", @"Promo Title 2", @"Promo Title 3"];
    
    // set static data of promoDetailsArray
    promoDetailsArray = @[
                          @"Here are the details for the Promo 1. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. \n\nThe quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.",
                         @"Here are the details for the Promo 2. Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? \n\nTwinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are? Twinkle, twinkle little star, how I wonder what you are?",
                         @"Here are the details for the Promo 3. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. \n\nWe went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch. We went to the italian restaurant yesterday and had our lunch."];
    
    
    //set transition
    [_slideshow setTransitionType:SlideShowTransitionFade];
    
    //start
    [_slideshow start];
    
    //set initial status of PromoInfoView
    self.promoInfoView.hidden = YES;
    self.promoInfoView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:85.0];
    [self.promoInfoView.layer setCornerRadius:10.0f];
    
    // Change the color of Sidebar
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it will show up the sidebar
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonPressed:(id)sender
{
    [_slideshow start];
    self.promoInfoView.hidden = YES;
    
}

- (IBAction)SlideShowStopButtonClicked:(id)sender
{
    [_slideshow stop];
    
    self.promoTitleLabel.text = promoTitleArray[_slideshow.currentIndex];
    _detailsTextView.text = promoDetailsArray[_slideshow.currentIndex];
    self.promoInfoView.hidden = NO;
}


- (IBAction)facebookButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/bonafidestore"]];
}

- (IBAction)twitterButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/bonafide_store"]];
}

- (IBAction)instagramButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://instagram.com/bonafidestore"]];
}

- (IBAction)tumblrButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bonafidestore.tumblr.com/"]];
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



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"newArrivalsWebSegue"])
    {
        // Open webSiteViewController:
        WebSiteViewController *webPage = [segue destinationViewController];
        
        [webPage setWebString:@"http://bnfde.com/collections/new-arrivals?"];
        [webPage setNavTitle:@"NEW ARRIVALS"];
    }
    
    else if ([segue.identifier isEqualToString:@"brandsWebSegue"])
    {
        // Open webSiteViewController:
        WebSiteViewController *webPage = [segue destinationViewController];
        
        [webPage setWebString:@"http://bnfde.com/pages/brand-portfolio?"];
        [webPage setNavTitle:@"BRANDS"];
    }
    
    else if ([segue.identifier isEqualToString:@"mensWebSegue"])
    {
        // Open webSiteViewController:
        WebSiteViewController *webPage = [segue destinationViewController];
        
        [webPage setWebString:@"http://bnfde.com/collections/all-product?"];
        [webPage setNavTitle:@"MENS"];
    }
    
    else if ([segue.identifier isEqualToString:@"collectionsWebSegue"])
    {
        // Open webSiteViewController:
        WebSiteViewController *webPage = [segue destinationViewController];
        
        [webPage setWebString:@"http://bnfde.com/pages/bnfde-collection?"];
        [webPage setNavTitle:@"COLLECTION"];
    }
    
    else
    {
        // Unknown status. Do nothing
    }
}

@end
