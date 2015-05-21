//
//  FileViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

@class RootViewController;

typedef enum {
    FileStateNormal = 1,
    FileStateSearch = 2,
}FileState;

typedef enum {
    FileOperationNormal = 0,
    FileOperationSelect = 1,
    FileOperationRead = 2,
}FileOperation;

@class FileViewController;

@protocol FileViewControllerDelegate <NSObject>

- (void)returnSelectedDoc:(NSDictionary*)record;

@end


@interface FileViewController : CommomTableViewController

@property (nonatomic, strong) NSObject<FileViewControllerDelegate> *delegate;

@property (nonatomic, assign) FileState fileState;
@property (nonatomic, assign) FileOperation fileOperation;


@property (strong, nonatomic) IBOutlet UIView *operationView;
@property (strong, nonatomic) IBOutlet UIButton *cutButton;
@property (strong, nonatomic) IBOutlet UIButton *pasteButton;
@property (strong, nonatomic) IBOutlet UIButton *renameButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) IBOutlet UIButton *sureButton;

@property (strong, nonatomic) IBOutlet UIView *fileView;

@property (nonatomic, strong) NSString *pathString;
@property (nonatomic, strong) NSString *titleStr;

@property (assign, nonatomic) BOOL isFileSelect;

@property (strong, nonatomic) NSString *caseClassId;

- (IBAction)touchNewFileEvent:(id)sender;
- (IBAction)touchNewDocEvent:(id)sender;

- (IBAction)touchCutEvent:(id)sender;
- (IBAction)touchPasteEvent:(id)sender;
- (IBAction)touchRenameEvent:(id)sender;
- (IBAction)touchFavoriteEvent:(UIButton*)sender;
- (IBAction)touchShareEvent:(id)sender;
- (IBAction)touchDeleteEvent:(id)sender;

- (IBAction)touchSureEvent:(id)sender;

- (IBAction)touchCloseEvent:(id)sender;

- (void)setRootView:(RootViewController*)rootViewController;

@end
