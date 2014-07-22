//
//  StoreMapViewController.h
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/20/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import "AnnotationClass.h"

@interface StoreMapViewController : UIViewController

// Public Outlets
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (nonatomic, retain) NSMutableArray *mapAnnotations;
+ (CGFloat)annotationPadding;

@end
