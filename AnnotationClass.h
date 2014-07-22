//
//  AnnotationClass.h
//  iOS6 Map
//
//  Created by Training on 9/21/12.
//  Copyright (c) 2012 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface AnnotationClass : NSObject <MKAnnotation>
{
    NSString *title;
    NSString *subtitle;
    UIImage *image;
}
// Public declarations:
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, retain) UIImage *image;

@end
