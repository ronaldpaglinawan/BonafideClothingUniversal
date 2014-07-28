//
//  promoIpadInfoViewController.h
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/24/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideShow.h"

@interface promoIpadInfoViewController : UIViewController

// Outlets
@property (strong, nonatomic) IBOutlet UIView *promoIpadView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@property (strong, nonatomic) NSString *chosenTitle;
@property (strong, nonatomic) NSString *chosenDescription;

// Actions
- (IBAction)dismissPromoView:(id)sender;

@end
