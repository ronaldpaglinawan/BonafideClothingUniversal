//
//  StoreMapViewController.m
//  BonafideClothingUniversal
//
//  Created by Ronald F. Paglinawan on 7/20/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "StoreMapViewController.h"
#import "SWRevealViewController.h"

static int kMapIndex = 0;

@interface StoreMapViewController ()

@end

@implementation StoreMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change the color of Sidebar
    _sidebarButton.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it will show up the sidebar
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
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
    //MapAnnotation.url = [[NSURL alloc] initWithString:@"www.google.com"];  // not working
    MapAnnotation.coordinate = region.center;
    
    [_mapView addAnnotation:[self.mapAnnotations objectAtIndex:kMapIndex]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (CGFloat)annotationPadding;
{
    return 10.0f;
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
            
            CGRect resizeRect;
            
            CGSize maxSize = CGRectInset(self.view.bounds,
                                         [StoreMapViewController annotationPadding],
                                         [StoreMapViewController annotationPadding]).size;
            
            
            if (resizeRect.size.width > maxSize.width)
                resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
            
            if (resizeRect.size.height > maxSize.height)
                resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
            
            resizeRect.origin = (CGPoint){0.0f, 0.0f};
            UIGraphicsBeginImageContext(resizeRect.size);
            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            annotationView.image = resizedImage;
            annotationView.opaque = NO;
            
            
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

@end
