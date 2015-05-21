//
//  DocumentViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-3.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "DocumentViewController.h"

#import <QuickLook/QuickLook.h>
#import "UIView+Utility.h"
#import "FileDownload.h"
#import "TextViewController.h"

@interface DocumentViewController ()<QLPreviewControllerDataSource,UINavigationControllerDelegate,QLPreviewControllerDelegate,FileDownloadDelegate,TextViewControllerDelegate>{
    FileDownload *_fileDownload;
    
    NSString *_path;
    
    QLPreviewController *previewController;
}

@end

@implementation DocumentViewController

@synthesize delegate = _delegate;

@synthesize pathString = _pathString;
@synthesize name = _name;
@synthesize type = _type;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_documentType == DocumentTypeWeb) {
        NSRange range = [_name rangeOfString:@"." options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            _name = [_name substringToIndex:range.location];
        }

//        if ([_name containsString:@"/"]) {
//            _name = [_name lastPathComponent];
//        }
        
        
        _fileDownload = [[FileDownload alloc] initWithPath:_pathString type:_type name:_name];
        _fileDownload.delegate = self;
        [_fileDownload startDownload];
        self.navigationController.navigationBar.translucent = NO;

    }
    else{
        _fileDownload = [[FileDownload alloc] init];
        _fileDownload.delegate = self;
        [_fileDownload saveData:_data type:_type name:_name];
        
    }
    
    
    
      // [self showProgressHUD:@""];
}



- (void)fileDownload:(FileDownload*)fileDownload path:(NSString*)path{
    [self hideProgressHUD:0];
    
    if ([_type isEqualToString:@"txt"]) {
        TextViewController *textViewController = [[TextViewController alloc] init];
        textViewController.textType = TextTypeRead;
        
        NSError *error;
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
       // NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!error) {
            textViewController.content = content;
            textViewController.delegate = self;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:textViewController];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        else{
        }
        
    }
    else{
        _path = path;
        previewController = [[QLPreviewController alloc] init];
        previewController.dataSource = self;
        previewController.delegate = self;
        [self presentViewController:previewController animated:NO completion:nil];
        previewController.navigationController.navigationBarHidden = NO;
        [previewController reloadData];
    }
}

- (void)dissView{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)fileStartDownload{
    [self showProgressHUD:@""];
}

- (void)fileDownloadError:(FileDownload*)fileDownload{
    [self hideProgressHUD:0];
    //[self showHUDWithTextOnly:@"打开失败"];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    


}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1; //assuming your code displays a single file
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    return [NSURL fileURLWithPath:_path];
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    if ([_delegate respondsToSelector:@selector(closeDocument)]) {
        [_delegate closeDocument];
    }
    [previewController dismissViewControllerAnimated:NO completion:nil];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"process_comment_read" object:nil];
}

@end
