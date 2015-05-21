//
//  PullToRefreshIndicator.m
//  Airport_ipad
//
//  Created by wuming on 11/11/13.
//  Copyright (c) 2013年 wuming. All rights reserved.
//


#import "PullToRefreshIndicator.h"

#import "NSDate+HumanInterval.h"

@implementation PullToRefreshIndicator

@synthesize lastUpdateTip = _lastUpdateTip;
@synthesize relativeDate = _relativeDate;
@synthesize pullToRefreshDelegate = _pullToRefreshDelegate;
@synthesize isDirectLoad = _isDirectLoad;
@synthesize scrollView = _scrollView;

- (void)setState:(PullState)pullState {
    if (_state == pullState) {
        return ;
    }
    
    _state = pullState;
    
    if (_state == PullStateHide || (_isDirectLoad && _state != PullStateLoading)) {
        self.hidden = YES;
        _scrollView.contentInset = UIEdgeInsetsZero;
        return ;
    }
    self.hidden = NO;
    
    // arrow
    _tipImage.hidden = NO;
    if (_state == PullStatePulling) {
        // rorate image
        [UIView beginAnimations:nil context:nil]; {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.3];
            
            _tipImage.transform = _originalTransform;
            
        }[UIView commitAnimations];
    }
    else if(_state == PullStateRelease) {
        // rorate image
        [UIView beginAnimations:nil context:nil]; {
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.3];
            _tipImage.transform = CGAffineTransformRotate(_originalTransform, M_PI);
        }[UIView commitAnimations];
    }
    else {
        _tipImage.hidden = YES;
    }
    
    // tip
    NSDictionary* arrowUI = [_tipUIs objectForKey:[NSNumber numberWithInt:_state]];
	NSString* tip = [arrowUI objectForKey:@"tip"];
    _tipLabel.text = tip;
    CGRect tipFrame = _tipLabel.frame;
    NSDictionary *textAttributes = @{NSFontAttributeName: _tipLabel.font};
    CGSize tipSize = [_tipLabel.text sizeWithAttributes:textAttributes];

    int i;
    NSUInteger len = [_tipLabel.text length];
    for ( i = (int)len; i > 1 ; --i) {
        unichar chararacter = [_tipLabel.text characterAtIndex:i-1];
        if (chararacter != '.') {
            break;
        }
    }
    NSString* removeDotTip;
    if (i > 0 && i < [_tipLabel.text length] ) {
        removeDotTip = [_tipLabel.text substringToIndex:i];
    }
    else {
        removeDotTip = _tipLabel.text;
    }
    
    tipFrame.origin.x = (self.frame.size.width - [removeDotTip sizeWithAttributes:textAttributes].width)/2.0;
    tipFrame.size = tipSize;
    
    // adjust postion
    if (_state == PullStateLoading) {
        if(_position == PullPositionAtLeft) {
            _scrollView.contentInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0);
        }
        else if(_position == PullPositionAtTop) {
            _scrollView.contentInset = UIEdgeInsetsMake(self.bounds.size.height, 0, 0, 0);
        }
		else if (_position == PullPositionAtBottom) {
			_scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.bounds.size.height, 0);
		}
        else if (_position == PullPositionAtRight) {
			_scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
		}
		
        CGRect indicatorFrame = _loadingIndicator.frame;
        indicatorFrame.origin.x = (self.frame.size.width - indicatorFrame.size.width)/2.0;
        if (_position == PullPositionAtTop || _position == PullPositionAtBottom) {
            indicatorFrame.origin.y = 5;
        }
        else if (_position == PullPositionAtLeft || _position == PullPositionAtRight) {
            indicatorFrame.origin.y = (self.frame.size.height - indicatorFrame.size.height)/2.0;
        }
        tipFrame.origin.y = indicatorFrame.origin.y + indicatorFrame.size.height + 5;
        
        _lastUpdateDateTimeLabel.hidden = YES;
        
        _loadingIndicator.frame = indicatorFrame;
        
        _lastUpdateDateTime = [NSDate date];
		[_loadingIndicator startAnimating];
        
	}
	else {
        if ( _lastUpdateDateTimeLabel && _lastUpdateDateTime ) {
            tipFrame.origin.y = 5;
            
            _lastUpdateDateTimeLabel.hidden = NO;
            NSString* lastUpdateTip = nil;
            if (_relativeDate == YES) {
                lastUpdateTip = [NSString stringWithFormat:@"%@：%@", _lastUpdateTip, [_lastUpdateDateTime humanIntervalSinceNow]];
            }
            else {
                lastUpdateTip = [NSString stringWithFormat:@"%@：%@", _lastUpdateTip, [_dateFormatter stringFromDate:_lastUpdateDateTime]];  
            }
            _lastUpdateDateTimeLabel.text = lastUpdateTip;
            [_lastUpdateDateTimeLabel sizeToFit];
            CGRect lastUpdateDateTimeLabelFrame = _lastUpdateDateTimeLabel.frame;
            lastUpdateDateTimeLabelFrame.origin.x = (self.frame.size.width - lastUpdateDateTimeLabelFrame.size.width)/2.0;
            lastUpdateDateTimeLabelFrame.origin.y = tipFrame.origin.y + tipFrame.size.height + 2;
            _lastUpdateDateTimeLabel.frame = lastUpdateDateTimeLabelFrame;
        }
        else {
            _lastUpdateDateTimeLabel.hidden = YES;
            tipFrame.origin.y = (self.frame.size.height - tipFrame.size.height)/2.0;
        }
        
        CGRect tipImageFrame = _tipImage.frame;
        
        if (_position == PullPositionAtTop || _position == PullPositionAtBottom) {
            CGFloat x = 0;
            if ( _lastUpdateDateTimeLabel && !_lastUpdateDateTimeLabel.hidden && _lastUpdateDateTimeLabel.frame.origin.x < tipFrame.origin.x) {
                x = _lastUpdateDateTimeLabel.frame.origin.x;
            }
            else {
                x = tipFrame.origin.x;
            }
            tipImageFrame.origin.x = x - _arrowOffset - tipImageFrame.size.width;
        }
        else if (_position == PullPositionAtLeft || _position == PullPositionAtRight) {
            tipImageFrame.origin.y = tipFrame.origin.y - _arrowOffset - tipImageFrame.size.height;
        }
        _tipImage.frame = tipImageFrame;
		[_loadingIndicator stopAnimating];
	}
    _tipLabel.frame = tipFrame;
    
    
}

- (void)setupControllers {
    _isDirectLoad = NO;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_scrollView addSubview:self];
    
    _tipUIs = [[NSMutableDictionary alloc] init];
    
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _tipLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	_tipLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:_tipLabel];
    
	_tipImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _tipImage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	[self addSubview:_tipImage];
    
    _originalTransform = _tipImage.transform;
	
    self.hidden = YES;
	[self setState:PullStateHide];
}

- (id)initWithPosition:(PullPosition)position scrollView:(UIScrollView*)scrollView {
    CGRect frame = CGRectZero;
    if (position == PullPositionAtTop || position == PullPositionAtBottom) {
        frame.size.width = scrollView.frame.size.width;
        if (position == PullPositionAtBottom) {
            frame.origin.y = scrollView.frame.size.height;
        }
    }
    else if (position == PullPositionAtLeft || position == PullPositionAtRight) {
        frame.size.height = scrollView.frame.size.height;
        if (position == PullPositionAtRight) {
            frame.origin.x = scrollView.frame.size.width;
        }
    }
    
    self = [super initWithFrame:frame];
    if (self) {
		_position = position;
        _scrollView = scrollView;
        _lastUpdateTip = @"最后更新";
        _relativeDate = NO;
        [self setupControllers];
        
    }
    return self;
}

- (Boolean)isLoading {
	return _state == PullStateLoading;
}

- (void)setupArrow:(UIImage*)arrow offset:(CGFloat)offset spacing:(CGFloat)spacing {
    _arrowOffset = offset;
    
    _tipImage.image = arrow;
    CGRect tipImageFrame = _tipImage.frame;
    CGRect selfFrame = self.frame;
    if (_position == PullPositionAtTop || _position == PullPositionAtBottom) {
        tipImageFrame.origin.y = spacing;
        selfFrame.size.height = arrow.size.height + spacing * 2;
        if (_position == PullPositionAtTop) {
            selfFrame.origin.y = -selfFrame.size.height;
        }
    }
    else if (_position == PullPositionAtLeft || _position == PullPositionAtRight) {
        tipImageFrame.origin.x = spacing;
        selfFrame.size.width = arrow.size.width + spacing * 2;
        if (_position == PullPositionAtLeft) {
            selfFrame.origin.x = -selfFrame.size.width;
        }
    }
    tipImageFrame.size = arrow.size;
    self.frame = selfFrame;
    _tipImage.frame = tipImageFrame;
}

- (void)setupTip:(NSString*)tip forState:(PullState)state {
    NSNumber* stateKey = [NSNumber numberWithInt:state];
    NSDictionary* existTipUI = [_tipUIs objectForKey:stateKey];
    if (existTipUI ) {
        if (!tip) {
            tip = [existTipUI objectForKey:@"tip"];
        }
    }
    [_tipUIs setObject:[NSDictionary dictionaryWithObjectsAndKeys:tip, @"tip", 
                        nil] 
                forKey:stateKey];
    
}

- (void)setupTip:(NSString *)tip {
    if (tip.length > 15) {
        tip = [NSString stringWithFormat:@"%@...", [tip substringToIndex:15]];
    }
    
    [self setupTip:tip forState:PullStatePulling];
    [self setupTip:tip forState:PullStateLoading];
    [self setupTip:tip forState:PullStateRelease];
}

- (void)setupTipFontSize:(CGFloat)tipFontSize color:(UIColor*)color {
    _tipLabel.font = [_tipLabel.font fontWithSize:tipFontSize];
    _tipLabel.textColor = color;
}

- (void)setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style {
    [_loadingIndicator removeFromSuperview];
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    _lastUpdateDateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
	[self addSubview:_loadingIndicator];
    [_loadingIndicator sizeToFit];
    
}

- (void)enableLastUpdateTip:(UIColor*)color fontSize:(CGFloat)fontSize dateFormatter:(NSDateFormatter*)dateFormatter {
    assert(!_lastUpdateDateTimeLabel);
    _dateFormatter = dateFormatter;
    
    [_lastUpdateDateTimeLabel removeFromSuperview];
    _lastUpdateDateTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _lastUpdateDateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    _lastUpdateDateTimeLabel.backgroundColor = [UIColor clearColor];
    _lastUpdateDateTimeLabel.font = [_lastUpdateDateTimeLabel.font fontWithSize:fontSize];
    _lastUpdateDateTimeLabel.textColor = color;
    [self addSubview:_lastUpdateDateTimeLabel];
    
}

- (void)didPull {
    if (_state == PullStateLoading || _state == PullStateError ) {
        return ;
    }
    
    CGFloat distance = 0;
	CGRect frame = self.frame;
    if(_position == PullPositionAtLeft) {
        distance = -_scrollView.contentOffset.x;
        frame.origin.x = -frame.size.width;
    }
    else if(_position == PullPositionAtTop) {
        distance = -_scrollView.contentOffset.y;
        frame.origin.y = -frame.size.height;
    }
	else if (_position == PullPositionAtBottom) {
		distance = _scrollView.contentOffset.y + _scrollView.frame.size.height - _scrollView.contentSize.height;
		frame.origin.y = _scrollView.contentSize.height;
	}
	else if (_position == PullPositionAtRight){
		distance = _scrollView.contentOffset.x + _scrollView.frame.size.width - _scrollView.contentSize.width;
		frame.origin.x = _scrollView.contentSize.width;
	}
    
 	else {
		assert(NO);
	}
    
    if (distance <= 0) {
        [self setState:PullStateHide];
        return ;
    }
    
    self.frame = frame;
    if (_isDirectLoad) {
        if (distance < 0) {
            [self setState:PullStatePulling]; 
        }
        else {
            [self setState:PullStateRelease];
        }
    }
    else {
        if ( ( 
              (
               distance < self.bounds.size.height && (_position == PullPositionAtBottom || _position == PullPositionAtTop)
               ) || 
              (
               distance < self.bounds.size.width && (_position == PullPositionAtRight || _position == PullPositionAtLeft)
               ) 
              ) 
            ) {
            [self setState:PullStatePulling];
        }
        else {
            [self setState:PullStateRelease];
        }
    }
}

- (void)didPullReleased {
    if ( _state == PullStateLoading ) {
        return ;
    }
    
    if (_state == PullStateRelease ) {
        [self setState:PullStateLoading];
        [_pullToRefreshDelegate didStartLoading:self];
    }
	else {
		[self setState:PullStateHide];
	}
}

- (void)hideIndicator {
    [self setState:PullStateHide];
    
}

- (void)didLoadComplete:(NSString*)error {
    if (error) {
        [self setState:PullStateError];
        [self performSelector:@selector(hideIndicator) withObject:nil afterDelay:1.0];
    }
    else {
        [self hideIndicator];
    }
}

- (void)dealloc {
    _scrollView = nil;
    [self removeFromSuperview];
}

@end
