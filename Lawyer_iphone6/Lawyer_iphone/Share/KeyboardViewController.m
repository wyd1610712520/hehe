//
//  KeyboardViewController.m
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController (){
    BOOL isKeyboardVisible;
    CGPoint activeTexfieldPosition;
    CGPoint lastScrollPoint;
    CGPoint originalScrollPoint;
    UIView* activeEditField;
    CGSize kbSize;
}

@end

@implementation KeyboardViewController

@synthesize scrollView, distanceFromKeyboard, scrollToPreviousPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.distanceFromKeyboard = DEFAULT_DISTACE_FROM_KEYBOARD;
    self->isKeyboardVisible = NO;
    self.scrollToPreviousPosition = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [[self scrollView] addGestureRecognizer:singleTap];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self->activeEditField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self deregisterFromKeyboardNotifications];
}

- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self->isKeyboardVisible = YES;
    CGFloat yTexfieldPosition = [self->activeEditField convertPoint:CGPointMake(0, 0) toView:self.view].y + self->activeEditField.frame.size.height;
    if(![UIApplication sharedApplication].statusBarHidden)
    {
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)
        {
            yTexfieldPosition += [UIApplication sharedApplication].statusBarFrame.size.width;
        }
        else
        {
            yTexfieldPosition += [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    yTexfieldPosition +=80;
    self->activeTexfieldPosition = CGPointMake(self->activeTexfieldPosition.x, yTexfieldPosition);
    self->lastScrollPoint = self.scrollView.contentOffset;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = nil;
    if(aNotification)
    {
        info = [aNotification userInfo];
        kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    }
    CGRect visibleArea = [[UIScreen mainScreen] bounds];
    
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)
    {
        if(aNotification)
            kbSize = CGSizeMake(kbSize.height, kbSize.width);
        visibleArea = CGRectMake(visibleArea.origin.x, visibleArea.origin.y, visibleArea.size.height, visibleArea.size.width);
    }
    visibleArea = CGRectMake(0, 0, visibleArea.size.width, visibleArea.size.height - kbSize.height);
    if (!CGRectContainsPoint(visibleArea, self->activeTexfieldPosition))
    {
        CGFloat yDeltaScroll = self->activeTexfieldPosition.y - visibleArea.size.height;
        CGPoint scrollPoint = CGPointMake(lastScrollPoint.x, lastScrollPoint.y + yDeltaScroll + self.distanceFromKeyboard);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self->isKeyboardVisible = NO;
    if(self.scrollToPreviousPosition)
        [self.scrollView setContentOffset:self->originalScrollPoint animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    [self textInputDidBeginEditing:sender];
}

- (void)textViewDidBeginEditing:(UITextView *)sender
{
    [self textInputDidBeginEditing:sender];
}

- (void)textInputDidBeginEditing:(UIView *)sender
{
    self->activeEditField = sender;
    if(self->isKeyboardVisible)
    {
        [self keyboardWillShow:nil];
        [self keyboardWasShown:nil];
    }
    else
    {
        self->originalScrollPoint = self.scrollView.contentOffset;
    }
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}



- (void)dealloc
{
}


@end
