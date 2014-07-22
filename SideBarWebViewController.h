//
//  SideBarWebViewController.h
//  BonafideClothingUniversal
//
//  Created by Bonafide Infotech Inc. on 7/21/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarWebViewController : UIViewController

// Public Outlets
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) NSString *sideBarWebString;
@end
