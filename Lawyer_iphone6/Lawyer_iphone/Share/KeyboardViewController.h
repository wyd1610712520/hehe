//
//  KeyboardViewController.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DISTACE_FROM_KEYBOARD       90

@interface KeyboardViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat distanceFromKeyboard;

@property (nonatomic, assign) BOOL scrollToPreviousPosition;

@end
