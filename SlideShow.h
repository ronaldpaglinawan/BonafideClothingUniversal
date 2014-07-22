//
//  SlideShow.h
//  BonafideClothing
//
//  Created by Pauline Milan on 7/10/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

typedef NS_ENUM(NSInteger,  SlideShowTransitionType)
{
     SlideShowTransitionFade,
     SlideShowTransitionSlide
};

typedef NS_ENUM(NSInteger,  SlideShowGestureType)
{
     SlideShowGestureTap,
     SlideShowGestureSwipe,
     SlideShowGestureAll
};

typedef NS_ENUM(NSUInteger,  SlideShowPosition)
{
     SlideShowPositionTop,
     SlideShowPositionBottom
};

typedef NS_ENUM(NSUInteger,  SlideShowState)
{
     SlideShowStateStopped,
     SlideShowStateStarted
};

@class  SlideShow;
@protocol  SlideShowDelegate <NSObject>
@optional
- (void)  SlideShowDidNext:( SlideShow *) slideShow;
- (void)  SlideShowDidPrevious:( SlideShow *) slideShow;
- (void)  SlideShowWillShowNext:( SlideShow *) slideShow;
- (void)  SlideShowWillShowPrevious:( SlideShow *) slideShow;
@end

@protocol  SlideShowDataSource <NSObject>
- (UIImage *)slideShow:( SlideShow *)slideShow imageForPosition:( SlideShowPosition)position;
@end

@interface  SlideShow : UIView

@property (nonatomic, unsafe_unretained) IBOutlet id < SlideShowDelegate> delegate;
@property (nonatomic, unsafe_unretained) id< SlideShowDataSource> dataSource;

@property  float delay;
@property  float transitionDuration;
@property  (readonly, nonatomic) NSUInteger currentIndex;
@property  (atomic)  SlideShowTransitionType transitionType;
@property  (atomic) UIViewContentMode imagesContentMode;
@property  (strong,nonatomic) NSMutableArray * images;
@property  (readonly, nonatomic)  SlideShowState state;

- (void) addImagesFromResources:(NSArray *) names;
- (void) emptyAndAddImagesFromResources:(NSArray *)names;
- (void) addGesture:( SlideShowGestureType)gestureType;
- (void) addImage:(UIImage *) image;
- (void) start;
- (void) stop;
- (void) previous;
- (void) next;

@end

