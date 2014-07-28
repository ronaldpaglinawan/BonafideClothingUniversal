//
//  MasterViewController.h
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/19/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *memberData;


@end
