//
//  MeidaViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileCoreServices/MobileCoreServices.h"

@class MeidaViewController;

@protocol MeidaViewControllerDelegate <NSObject>

- (void)meidaViewController:(MeidaViewController*)meidaViewController fileData:(NSData*)fileData type:(NSString*)type;

@end

@interface MeidaViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;

@property (nonatomic, strong) NSObject<MeidaViewControllerDelegate> *delegate;

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *tap;

@property (nonatomic, strong) IBOutlet UIButton *fileButton;

- (IBAction)touchCloseEvent:(id)sender;

- (IBAction)touchPhotoEvent:(id)sender;
- (IBAction)touchCameraEvent:(id)sender;
- (IBAction)touchAudioEvent:(id)sender;
- (IBAction)touchVideoEvent:(id)sender;
- (IBAction)touchDocEvent:(id)sender;
- (IBAction)touchtextEvent:(id)sender;


@end
