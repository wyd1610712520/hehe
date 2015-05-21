//
//  SetupViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-11.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "SetupViewController.h"


#import "RootViewController.h"

#import "ShareViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import "PasswordViewController.h"

#import "AboutViewController.h"
#import "SeggestViewController.h"

#import "CommomClient.h"

#import "WebViewController.h"

#import "UIButton+AFNetworking.h"

@interface SetupViewController ()<UIAlertViewDelegate>{
    
    CommomClient *_commomClient;
    
    RootViewController *_rootViewController;
    
    ShareViewController *_shareViewController;
    HomeViewController *_homeViewController;
    ProfileViewController *_profileViewController;
    PasswordViewController *_passwordViewController;
    
    NSFileManager *_fileManager;

    float _fileSize;
    
    NSString *docPath;
    
    WebViewController *_webViewController;
}

@end

@implementation SetupViewController

@synthesize contentView = _contentView;
@synthesize scrollView = _scrollView;
@synthesize secondView = _secondView;

@synthesize avatorButton = _avatorButton;

@synthesize lineImageView = _lineImageView;

@synthesize nameLabel = _nameLabel;

+ (SetupViewController *)sharedInstance
{
    __strong static SetupViewController *instance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        instance = [[SetupViewController alloc] init];
    });
    return instance;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _nameLabel.text = [_commomClient getValueFromUserInfo:@"userName"];
    
    self.navigationController.navigationBarHidden = YES;
    _homeViewController.view.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _homeViewController.view.hidden = YES;
    
    
}



- (void)setHomeView:(HomeViewController*)homeViewController{
    _homeViewController = homeViewController;
    

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGRect frame = _contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = self.view.frame.size.height;
    frame.size.width = vector_x;
    _contentView.frame = frame;
     _secondView.frame = frame;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _commomClient = [CommomClient sharedInstance];
    
    
    
    
    [self.view addSubview:_contentView];
    
    
 
    
    self.navigationController.navigationBarHidden = YES;
    _homeViewController.view.hidden = NO;
    
    
    //可以优化（在需要的时候加载）
    _rootViewController = [RootViewController sharedInstance];
    
    _shareViewController = [[ShareViewController alloc] init];
    _shareViewController.shareType = ShareTypeDefault;
    
    _profileViewController = [[ProfileViewController alloc] init];
    _passwordViewController = [[PasswordViewController alloc] init];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docPath = [[paths lastObject] stringByAppendingPathComponent:@"Files"];
    
    _fileSize = [self folderSizeAtPath:docPath];
    _sizeLabel.text = [NSString stringWithFormat:@"%.2fM",_fileSize];
    
    NSString *path = [_commomClient getValueFromUserInfo:@"empPhoto"];
    //[_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];
    [_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    _avatorButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAvator:) name:AvatorUpdate object:nil];
}

- (void)updateAvator:(NSNotification*) notification{
    NSString *path = [_commomClient getValueFromUserInfo:@"empPhoto"];
    //[_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path]];

    [_avatorButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"avator.png"]];
}


- (IBAction)touchAvatorEvent:(id)sender{
    _profileViewController.profileType = ProfileTypeNormal;
    
    [self.navigationController pushViewController:_profileViewController animated:YES];
}

- (IBAction)touchPasswrodEvent:(id)sender{
    [self.navigationController pushViewController:_passwordViewController animated:YES];
    
}

- (IBAction)touchClearDataEvent:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:docPath error:nil];
        if (!error) {
            [self showHUDWithTextOnly:@"清除成功"];
            _sizeLabel.text = @"";
        }
        else{
            [self showHUDWithTextOnly:@"清除失败"];
        }
    }
}

- (IBAction)touchHelpEvent:(id)sender{
    _webViewController = [[WebViewController alloc] init];
    _webViewController.path = @"http://www.elinklaw.com/training/apphelp.html";
    _webViewController.title = @"在线帮助";
    [self.navigationController pushViewController:_webViewController animated:YES];
}

- (IBAction)touchCommentDataEvent:(id)sender{
    SeggestViewController *seggestViewController = [[SeggestViewController alloc] init];
    [self.navigationController pushViewController:seggestViewController animated:YES];
}

- (IBAction)touchAboutDataEvent:(id)sender{
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (IBAction)touchShareEvent:(id)sender{
    [_shareViewController show];
}

- (IBAction)touchExitEvent:(id)sender{
    [self.revealContainer showCenter];
    [[CommomClient sharedInstance] removeAccount];
    
    
    [[RootViewController sharedInstance] dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)reloadInputViews{
    [super reloadInputViews];
}

- (float)folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end