//
//  ShareViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#define downloadUrl @"http://test.elinklaw.com"

typedef enum {
    ShareTypeCustom = 0,
    ShareTypeDefault = 1,
}ShareType;

@interface ShareViewController : UIViewController

@property (nonatomic, assign) ShareType shareType;

@property (nonatomic, strong) IBOutlet UIButton *qqButton;
@property (nonatomic, strong) IBOutlet UIButton *yixinButton;
@property (nonatomic, strong) IBOutlet UIButton *wFriendButton;
@property (nonatomic, strong) IBOutlet UIButton *wGroupButton;
@property (nonatomic, strong) IBOutlet UIButton *sinaButton;
@property (nonatomic, strong) IBOutlet UIButton *messageButton;
@property (nonatomic, strong) IBOutlet UIButton *emailButton;


+ (ShareViewController *)sharedInstance;

- (IBAction)touchCancelEvent:(id)sender;

- (IBAction)touchQQEvent:(UIButton*)sender;
- (IBAction)touchYixinEvent:(UIButton*)sender;
- (IBAction)touchWFriendEvent:(UIButton*)sender;
- (IBAction)touchWGroupEvent:(UIButton*)sender;
- (IBAction)touchSinaEvent:(UIButton*)sender;
- (IBAction)touchMessageEvent:(UIButton*)sender;
- (IBAction)touchEmailEvent:(UIButton*)sender;

- (void)sendInfo:(NSData*)data
           title:(NSString*)title
          descri:(NSString*)descri
       redictUrl:(NSString*)redictUrl;

- (void)show;

@end
