//
//  MeidaViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "MeidaViewController.h"

#import "AudioViewController.h"

#import "TextViewController.h"

#import "UIViewController+Navigation.h"


@interface MeidaViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,AudioViewControllerDelegate,TextViewControllerDelegate>{
    
    TextViewController *_textViewController;
    
    UIImagePickerController *_imagePickerController;
    
    BOOL isCameraSupport;
    
    AudioViewController *_audioViewController;
    
    NSString *_curText;
}

@end

@implementation MeidaViewController

@synthesize contentView = _contentView;
@synthesize backgroundView = _backgroundView;

@synthesize delegate = _delegate;

@synthesize tap = _tap;

- (id)init{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return self;
}


- (IBAction)touchCloseEvent:(id)sender{
    [self.view removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMedia" object:nil];
}

- (IBAction)touchPhotoEvent:(id)sender{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}


- (IBAction)touchCameraEvent:(id)sender{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
     _imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (IBAction)touchAudioEvent:(id)sender{
    [self presentViewController:[self getNavigation:_audioViewController] animated:YES completion:nil];
}

- (IBAction)touchVideoEvent:(id)sender{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (IBAction)touchDocEvent:(id)sender{
    
    
}

- (IBAction)touchtextEvent:(id)sender{
    [self presentViewController:[self getNavigation:_textViewController] animated:YES completion:nil];
}

- (void)textViewController:(TextViewController *)textViewController text:(NSString *)text{
    _curText = text;
    NSData *data = [_curText dataUsingEncoding:NSUTF8StringEncoding];
    if ([_delegate respondsToSelector:@selector(meidaViewController:fileData:type:)]) {
        [_delegate meidaViewController:self fileData:data type:@"txt"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    _audioViewController = [[AudioViewController alloc] init];
    _audioViewController.delegate = self;
    
    
    _textViewController = [[TextViewController alloc] init];
    _textViewController.delegate = self;
    
     
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)audioViewController:(AudioViewController*)audioViewController path:(NSString*)path{
    NSData *audioData = [[NSData alloc] initWithContentsOfFile:path];
    if ([_delegate respondsToSelector:@selector(meidaViewController:fileData:type:)]) {
        [_delegate meidaViewController:self fileData:audioData type:@"caf"];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
    }
    else
    {
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSData *imageData = UIImageJPEGRepresentation(theImage, 0.5);
        if ([_delegate respondsToSelector:@selector(meidaViewController:fileData:type:)]) {
            [_delegate meidaViewController:self fileData:imageData type:@"jpg"];
            
        }
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *data = [NSData dataWithContentsOfURL:mediaURL];
        if ([_delegate respondsToSelector:@selector(meidaViewController:fileData:type:)]) {
            [_delegate meidaViewController:self fileData:data type:@"mov"];
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
