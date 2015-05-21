//
//  PullToRefreshIndicator.h
//  Airport_ipad
//
//  Created by wuming on 11/11/13.
//  Copyright (c) 2013年 wuming. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    PullStateHide, 
    PullStatePulling, 
    PullStateLoading, 
    PullStateRelease, 
    PullStateError, 
}PullState;

typedef enum {
    PullPositionAtLeft, 
    PullPositionAtTop, 
	PullPositionAtBottom, 
	PullPositionAtRight, 
}PullPosition;

typedef enum { 
    ActivityIndicatorPositionUp, 
    ActivityIndicatorPositionLeft, 
} ActivityIndicatorPosition;

@protocol PullToRefreshDelegate;

@interface PullToRefreshIndicator : UIView {
    UIImageView *_tipImage;
    
    UILabel* _lastUpdateDateTimeLabel;
    NSDate* _lastUpdateDateTime;
    UIActivityIndicatorView *_loadingIndicator;
    
    Boolean _isPullReleased;
    
    PullState _state;
	PullPosition _position;
    
    NSObject<PullToRefreshDelegate>* __unsafe_unretained _pullToRefreshDelegate;
    
    NSMutableDictionary *_tipUIs;
    
    CGFloat _arrowOffset;
    CGAffineTransform _originalTransform;
    
    NSDateFormatter* _dateFormatter;

}
@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong)NSString* lastUpdateTip;
@property (nonatomic, assign)Boolean relativeDate;
@property (nonatomic, unsafe_unretained) NSObject<PullToRefreshDelegate>* pullToRefreshDelegate;
@property (nonatomic, assign) Boolean isDirectLoad;
@property (nonatomic, unsafe_unretained) UIScrollView* scrollView;

- (id)initWithPosition:(PullPosition)position scrollView:(UIScrollView*)scrollView;

- (void)setupArrow:(UIImage*)arrow offset:(CGFloat)offset spacing:(CGFloat)spacing;
- (void)setupTip:(NSString*)tip forState:(PullState)state;
- (void)setupTip:(NSString *)tip;
- (void)setupTipFontSize:(CGFloat)tipFontSize color:(UIColor*)color;
- (void)setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;
- (void)enableLastUpdateTip:(UIColor*)color fontSize:(CGFloat)fontSize dateFormatter:(NSDateFormatter*)dateFormatter;

- (void)setState:(PullState)pullState;

- (void)didPull;
- (void)didPullReleased;
- (void)didLoadComplete:(NSString*)error;

- (Boolean)isLoading;

@end

@protocol PullToRefreshDelegate
@required
- (void)didStartLoading:(PullToRefreshIndicator*)indicator;
@end