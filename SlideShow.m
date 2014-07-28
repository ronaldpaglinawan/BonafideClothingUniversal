//
//  SlideShow.m
//  BonafideClothing
//
//  Created by Pauline Milan on 7/10/14.
//  Copyright (c) 2014 Bonafideinfotech Inc. All rights reserved.
//

#import "SlideShow.h"

#define kSwipeTransitionDuration 0.25

typedef NS_ENUM(NSInteger,  SlideShowSlideMode)
{
     SlideShowSlideModeForward,
     SlideShowSlideModeBackward
};

@interface  SlideShow()
@property (atomic) BOOL doStop;
@property (atomic) BOOL isAnimating;
@property (strong,nonatomic) UIImageView * topImageView;
@property (strong,nonatomic) UIImageView * bottomImageView;

@end

@implementation  SlideShow

@synthesize delegate;
@synthesize delay;
@synthesize transitionDuration;
@synthesize transitionType;
@synthesize images;

- (void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    
    [self setDefaultValues];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (void) setDefaultValues
{
    self.clipsToBounds = YES;
    self.images = [NSMutableArray array];
    _currentIndex = 0;
    delay = 3;
    
    transitionDuration = 1;
    transitionType =  SlideShowTransitionFade;
    _doStop = YES;
    _isAnimating = NO;
    
    _topImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _bottomImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _topImageView.autoresizingMask = _bottomImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _topImageView.clipsToBounds = YES;
    _bottomImageView.clipsToBounds = YES;
    [self setImagesContentMode:UIViewContentModeScaleAspectFit];
    
    [self addSubview:_bottomImageView];
    [self addSubview:_topImageView];
}

- (void) setImagesContentMode:(UIViewContentMode)mode
{
    _topImageView.contentMode = mode;
    _bottomImageView.contentMode = mode;
}

- (UIViewContentMode) imagesContentMode
{
    return _topImageView.contentMode;
}

- (void) addGesture:( SlideShowGestureType)gestureType
{
    switch (gestureType)
    {
        case  SlideShowGestureTap:
            [self addGestureTap];
            break;
            
        case  SlideShowGestureSwipe:
            [self addGestureSwipe];
            break;
            
        case  SlideShowGestureAll:
            [self addGestureTap];
            [self addGestureSwipe];
            break;
            
        default:
            break;
    }
}

- (void) addImagesFromResources:(NSArray *) names
{
    for(NSString * name in names)
    {
        [self addImage:[UIImage imageNamed:name]];
    }
}

- (void) addImage:(UIImage*) image
{
    [self.images addObject:image];
    
    if([self.images count] == 1)
    {
        _topImageView.image = image;
    }
    
    else if([self.images count] == 2)
    {
        _bottomImageView.image = image;
    }
}

- (void) emptyAndAddImagesFromResources:(NSArray *)names
{
    [self.images removeAllObjects];
    _currentIndex = 0;
    [self addImagesFromResources:names];
}

- (void) start
{
    _doStop = NO;
    [self next];
}

- (void) next
{
    if(! _isAnimating && ([self.images count] >1 || self.dataSource))
    {
        
        // Next Image
        if (self.dataSource)
        {
            _topImageView.image = [self.dataSource slideShow:self imageForPosition: SlideShowPositionTop];
            _bottomImageView.image = [self.dataSource slideShow:self imageForPosition: SlideShowPositionBottom];
        }
        
        else
        {
            NSUInteger nextIndex = (_currentIndex+1)%[self.images count];
            _topImageView.image = self.images[_currentIndex];
            _bottomImageView.image = self.images[nextIndex];
            _currentIndex = nextIndex;
        }
        
        // Animate
        switch (transitionType)
        {
            case  SlideShowTransitionFade:
                [self animateFade];
                break;
                
            case  SlideShowTransitionSlide:
                [self animateSlide: SlideShowSlideModeForward];
                break;
                
        }

    }
}


- (void) previous
{
    if(! _isAnimating && ([self.images count] >1 || self.dataSource))
    {
        
        if ([self.delegate respondsToSelector:@selector( SlideShowWillShowPrevious:)]) [self.delegate  SlideShowWillShowPrevious:self];
        
        // Previous image
        if (self.dataSource)
        {
            _topImageView.image = [self.dataSource slideShow:self imageForPosition: SlideShowPositionTop];
            _bottomImageView.image = [self.dataSource slideShow:self imageForPosition: SlideShowPositionBottom];
        }
        
        else
        {
            NSUInteger prevIndex;
            
            if(_currentIndex == 0)
            {
                prevIndex = [self.images count] - 1;
            }
            
            else
            {
                prevIndex = (_currentIndex-1)%[self.images count];
            }
            _topImageView.image = self.images[_currentIndex];
            _bottomImageView.image = self.images[prevIndex];
            _currentIndex = prevIndex;
        }
        
        // Animate
        switch (transitionType)
        {
            case  SlideShowTransitionFade:
                [self animateFade];
                break;
                
            case  SlideShowTransitionSlide:
                [self animateSlide: SlideShowSlideModeBackward];
                break;
        }
        
        // Call delegate
        if([delegate respondsToSelector:@selector( SlideShowDidPrevious:)])
        {
            [delegate  SlideShowDidPrevious:self];
        }
    }
    
}

- (void) animateFade
{
    _isAnimating = YES;
    
    [UIView animateWithDuration:transitionDuration
                     animations:^{
                         _topImageView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         
                         _topImageView.image = _bottomImageView.image;
                         _topImageView.alpha = 1;
                         
                         _isAnimating = NO;
                         
                         if(! _doStop){
                             [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(next) object:nil];
                             [self performSelector:@selector(next) withObject:nil afterDelay:delay];
                         }
                     }];
}

- (void) animateSlide:( SlideShowSlideMode) mode
{
    _isAnimating = YES;
    
    if(mode ==  SlideShowSlideModeBackward)
    {
        _bottomImageView.transform = CGAffineTransformMakeTranslation(- _bottomImageView.frame.size.width, 0);
    }
    
    else if(mode ==  SlideShowSlideModeForward)
    {
        _bottomImageView.transform = CGAffineTransformMakeTranslation(_bottomImageView.frame.size.width, 0);
    }
    
    
    [UIView animateWithDuration:transitionDuration
                     animations:^{
                         
                         if(mode ==  SlideShowSlideModeBackward)
                         {
                             _topImageView.transform = CGAffineTransformMakeTranslation( _topImageView.frame.size.width, 0);
                             _bottomImageView.transform = CGAffineTransformMakeTranslation(0, 0);
                         }
                         
                         else if(mode ==  SlideShowSlideModeForward)
                         {
                             _topImageView.transform = CGAffineTransformMakeTranslation(- _topImageView.frame.size.width, 0);
                             _bottomImageView.transform = CGAffineTransformMakeTranslation(0, 0);
                         }
                     }
                     completion:^(BOOL finished){
                         
                         _topImageView.image = _bottomImageView.image;
                         _topImageView.transform = CGAffineTransformMakeTranslation(0, 0);
                         
                         _isAnimating = NO;
                         
                         if(! _doStop)
                         {
                             [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(next) object:nil];
                             [self performSelector:@selector(next) withObject:nil afterDelay:delay];
                         }
                     }];
}


- (void) stop
{
    _doStop = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(next) object:nil];
}

- ( SlideShowState)state
{
    return !_doStop;
}

#pragma mark - Gesture Recognizers initializers
- (void) addGestureTap
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          
                                                          initWithTarget:self action:@selector(handleSingleTap:)];
    
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:singleTapGestureRecognizer];
}

- (void) addGestureSwipe
{
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:swipeLeftGestureRecognizer];
    [self addGestureRecognizer:swipeRightGestureRecognizer];
}

#pragma mark - Gesture Recognizers handling
- (void)handleSingleTap:(id)sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)sender;
    CGPoint pointTouched = [gesture locationInView:self.topImageView];
    
    if (pointTouched.x <= self.topImageView.center.x)
    {
        [self previous];
    }
    else
    {
        [self next];
    }
}

- (void) handleSwipe:(id)sender
{
    UISwipeGestureRecognizer *gesture = (UISwipeGestureRecognizer *)sender;
    
    float oldTransitionDuration = self.transitionDuration;
    
    self.transitionDuration = kSwipeTransitionDuration;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self next];
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self previous];
    }
    
    self.transitionDuration = oldTransitionDuration;
}

@end


