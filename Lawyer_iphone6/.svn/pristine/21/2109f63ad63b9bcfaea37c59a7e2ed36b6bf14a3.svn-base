//
//  FileViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "FileViewController.h"

#import "HttpClient.h"

#import "FileCell.h"
#import "CommomClient.h"

#import "FileRightViewController.h"
#import "UIView+Utility.h"
#import "RevealViewController.h"
#import "RootViewController.h"

#import "AlertView.h"
#import "NewFileViewController.h"
#import "ShareViewController.h"

#import "DocumentViewController.h"

@interface FileViewController ()<UITableViewDataSource,UIAlertViewDelegate,FileRightViewControllerDelegate,UITableViewDelegate,RequestManagerDelegate,PullToRefreshDelegate,FileCellDelegate,AlertViewDelegate>{
    FileRightViewController *_fileRightViewController;
    
    HttpClient *_listHttpClient;
    NSString *_pathId;
    
    NSMutableArray *_paths;
    
    NSDictionary *_searchdic;
    
    NSDictionary *_record;
    
    RootViewController *_rootViewController;
    
    NSInteger _paper;
    
    NSString *_selectTitle;
    
    NSMutableArray *_selectFileStr;
    NSMutableArray *_selectDocStr;
    NSMutableArray *_selecteArrs;
    
    AlertView *_renameAlertView;
    
    NSString *_targetDocID;
    
    HttpClient *_renameHttpClient;
    
    BOOL isCut;
    
    BOOL isManager;
    
    NSString *_titleKey;
    NSString *_nameKey;
    
    HttpClient *_deleteHttpClient;
    
    HttpClient *_pasteHttpClient;
    HttpClient *_favoriteHttpClient;
    HttpClient *_cancelHttpClient;
    ShareViewController *_shareViewController;
    
    DocumentViewController *documentViewController;
    
    NewFileViewController *_newFileViewController;
    
    NSString *_isNew;
    
    AlertView *_newDocAlertView;
    
    HttpClient *_newDocHttpClient;
    
    NSIndexPath *_deleteIndexPath;
    
    NSString *_prite;
    
    NSDictionary *_selectPathdic;
    
    BOOL _isMoveDelete;
    
    BOOL _isDeleting;
}

@end

@implementation FileViewController

@synthesize fileState = _fileState;
@synthesize fileOperation = _fileOperation;
@synthesize pathString = _pathString;

- (id)init{
    self = [super init];
    if (self) {
        _pathString = [[NSString alloc] initWithFormat:@""];
    }
    return self;
}

UIImage *folderImage = nil;

+ (void)initialize{
    folderImage = [UIImage imageNamed:@"file_logo.png"];

}


- (void)setRootView:(RootViewController *)rootViewController{
    _rootViewController = rootViewController;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   //[_listHttpClient startRequest:[self fileParams:_pathId]];
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
}

- (void)touchRightEvent{
   //  [self showRight];
    
    if (_paper == 0) {
        for (NSLayoutConstraint *layout in _rootViewController.fileRightViewController.buttonView.constraints) {
            if (layout.firstAttribute == NSLayoutAttributeHeight) {
                layout.constant=0;
            }
        }
        _rootViewController.fileRightViewController.classid = @"M0";
        _rootViewController.fileRightViewController.buttonView.hidden = YES;
    }
    else{
        _rootViewController.fileRightViewController.classid = _pathId;
        NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
//        NSRange range2 = [_pathString rangeOfString:@"本人承办案件文档/正式案件"];
//        
//        if (range1.location || range2.location) {
//            _isMoveDelete = YES;
//        }
        
        if (range1.location != NSNotFound) {
            for (NSLayoutConstraint *layout in _rootViewController.fileRightViewController.buttonView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant=110;
                    _rootViewController.fileRightViewController.firstLineView.hidden = NO;
                }
            }
            _rootViewController.fileRightViewController.orderButton.hidden = NO;
            _rootViewController.fileRightViewController.manegerButton.hidden = NO;

        }
       else{
            for (NSLayoutConstraint *layout in _rootViewController.fileRightViewController.buttonView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant=56;
                    _rootViewController.fileRightViewController.firstLineView.hidden = YES;
                }
            }
            _rootViewController.fileRightViewController.manegerButton.hidden = YES;

        }
        
     
        _rootViewController.fileRightViewController.buttonView.hidden = NO;
    }
    [self.revealContainer showRight];
}

- (void)dismiss{
    _titleKey = @"";
    _nameKey = @"";
    if (_fileState == FileStateNormal || _fileState == FileStateSearch) {
        if ([[_paths lastObject] isKindOfClass:[NSString class]]) {
            if ([[_paths lastObject] isEqualToString:@"search/"]) {
                [_paths removeLastObject];
            }
            
        }
        else{
            _paper--;
            if (_paths.count > 1) {
                
                
                _pathId = [[_paths objectAtIndex:_paths.count - 2] objectForKey:@"dc_doc_class"];
                [_listHttpClient startRequest:[self fileParams:_pathId]];
                [_paths removeLastObject];
                
                
                if (_fileOperation == FileOperationNormal ) {
                    if (!isManager) {
                        NSDictionary *mapping = (NSDictionary*)[_paths lastObject];
                        _isNew = [mapping objectForKey:@"docRight"];
                        if ([_isNew isEqualToString:@"true"]) {
                            NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
                            NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
                            NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
                            [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
                            
                        }
                        else{
                            [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
                        }
                    }
                }
                
                
                NSMutableString *strPath = [[NSMutableString alloc] init];
                for (NSDictionary *mapping in _paths) {
                    [strPath appendFormat:@"%@/",[mapping objectForKey:@"dc_description"]];
                }
                
                
                if (_fileOperation == FileOperationNormal) {
                    _pathString = strPath;
                }
                else{
                    if (_titleStr.length > 0) {
                        _pathString = [NSString stringWithFormat:@"%@%@",_titleStr,strPath];
                    }
                    else{
                        _pathString = strPath;
                    }
                    
                }
                
                
                
                
                [self updateTableDelete];

                
            }
            else if(_paths.count == 1){
                
                NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
                if (range1.location != NSNotFound && isManager) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否退出管理状态?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alertView show];
                    return;
                }
                
                
                if (_fileOperation == FileOperationNormal) {
                    [_paths removeAllObjects];
                    _pathId = nil;
                    [_listHttpClient startRequest:[self fileParams:_pathId]];
                    
                    
                    if (!isManager) {
                        NSDictionary *mapping = (NSDictionary*)[_paths lastObject];
                        _isNew = [mapping objectForKey:@"docRight"];
                        if ([_isNew isEqualToString:@"true"]) {
                            NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
                            NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
                            NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
                            [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
                            
                            
                        }
                        else{
                            [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
                        }
                    }
                    NSMutableString *strPath = [[NSMutableString alloc] init];
                    for (NSDictionary *mapping in _paths) {
                        [strPath appendFormat:@"%@/",[mapping objectForKey:@"dc_description"]];
                    }
                    _pathString = strPath;
                    
                    
                    
                    [self updateTableDelete];

                }
                else{
                    [_listHttpClient startRequest:[self fileParams:_caseClassId]];
                    [_paths removeLastObject];
                    _pathString = _titleStr;
                }
                
                
                
                
               
                
            }
            else{
                [super dismiss];
                
            }
            
        }

    }
//    else if (_fileState == FileStateSearch){
//        [super dismiss];
//    }
    
}

- (void)updateTableDelete{
    NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
    NSRange range2 = [_pathString rangeOfString:@"本人承办案件文档/正式案件"];
    
    if (range2.location != NSNotFound || range1.location != NSNotFound) {
        _isMoveDelete = YES;
    }
    else{
        _isMoveDelete = NO;
        
    }
    if (![_isNew isEqualToString:@"true"]) {
        _isMoveDelete = NO;
    }
    
    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [self touchCancelEvent];
        [_paths removeAllObjects];
        _pathId = nil;
        [_listHttpClient startRequest:[self fileParams:_pathId]];
        if (_fileOperation == FileOperationNormal) {
            if (!isManager) {
                NSDictionary *mapping = (NSDictionary*)[_paths lastObject];
                _isNew = [mapping objectForKey:@"docRight"];
                if ([_isNew isEqualToString:@"true"]) {
                    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
                    NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
                    NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
                    [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
                    
                }
                else{
                    [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
                }
            }
        }
        
        
        

    }
}

#pragma mark - PullToRefreshDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.topRefreshIndicator didPull];
    if (self.tableDatas.count == 0) {
        return;
    }
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.topRefreshIndicator didPullReleased];
    if (self.tableDatas.count == 0) {
        return;
    }
}

- (void)didStartLoading:(PullToRefreshIndicator*)indicator{
    
    
    if (_fileOperation == FileOperationNormal) {
        if (indicator == self.topRefreshIndicator) {
            _titleKey = @"";
            _nameKey = @"";
            if (_searchdic.count > 0) {
                [_listHttpClient startRequest:_searchdic];
            }
            else{
                [_listHttpClient startRequest:[self fileParams:_pathId]];
            }
            
            

        }
    }
    else{
        [self.topRefreshIndicator didLoadComplete:nil];
    }
   
}


- (void)eceivesUpdate{
    [_listHttpClient startRequest:[self fileParams:_pathId]];
}

- (IBAction)touchSureEvent:(id)sender{
    if (_selectPathdic > 0) {
        if ([_delegate respondsToSelector:@selector(returnSelectedDoc:)]) {
            
            [_delegate returnSelectedDoc:_selectPathdic];
            
        }
    }
    else{
        [self showHUDWithTextOnly:@"请选择文件夹"];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eceivesUpdate) name:@"file_update" object:nil];
    
    [self setDismissButton];
    [self showTable];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
    
    
    _titleKey = @"";
    _nameKey = @"";
    
    self.topRefreshIndicator.pullToRefreshDelegate = self;
    
    if (_fileOperation == FileOperationSelect) {
        _sureButton.hidden = NO;
        CGRect frame = self.tableView.frame;
        frame.size.height -= 50;
        self.tableView.frame = frame;
        
       
    }
    else if (_fileOperation == FileOperationRead){
        
    }
    else{
        [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
    }
    
    _pathString = _titleStr;
    UINib *cellNib = [UINib nibWithNibName:@"FileCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FileCell"];
    
    _paths = [[NSMutableArray alloc] init];
    
    _rootViewController.fileRightViewController.delegate = self;
    [self.view bringSubviewToFront:_operationView];
    
    _shareViewController = [[ShareViewController alloc] init];
    _shareViewController.shareType = ShareTypeCustom;
    
    _renameHttpClient = [[HttpClient alloc] init];
    _renameHttpClient.delegate = self;
    
    _favoriteHttpClient = [[HttpClient alloc] init];
    _favoriteHttpClient.delegate = self;
    
    _cancelHttpClient = [[HttpClient alloc] init];
    _cancelHttpClient.delegate = self;
    
    _operationView.hidden = YES;
    
    [self setTitle:[Utility localizedStringWithTitle:@"file_nav_title"] color:nil];
    
    
    _listHttpClient = [[HttpClient alloc] init];
    _listHttpClient.delegate = self;
    
    if (_caseClassId.length > 0) {
        [_listHttpClient startRequest:[self fileParams:_caseClassId]];
    }
    else{
        [_listHttpClient startRequest:[self fileParams:_pathId]];
    }
    
    
    
    _deleteHttpClient = [[HttpClient alloc] init];
    _deleteHttpClient.delegate = self;
    
    _newDocHttpClient = [[HttpClient alloc] init];
    _newDocHttpClient.delegate = self;
}

- (void)fileRightView:(NSString*)title name:(NSString*)name{
    _titleKey = title;
    _nameKey = name;
}

- (void)fileRightViewController:(FileRightViewController *)fileRightViewController searchDic:(NSDictionary *)searchDic{
    _fileState = FileStateSearch;
    _searchdic = searchDic;
    [_listHttpClient startRequest:searchDic];
}

- (void)didTouchManageEvnet{
    isManager = YES;
    
    CGRect frame = self.tableView.frame;
    frame.size.height = self.view.frame.size.height -55;
    self.tableView.frame = frame;
    
    _selectFileStr = [[NSMutableArray alloc] init];
    _selectDocStr = [[NSMutableArray alloc] init];
    _selecteArrs = [[NSMutableArray alloc] init];

    _isFileSelect = NO;
    _fileOperation = FileOperationSelect;
    _operationView.hidden = NO;
    [self.tableView reloadData];
    [self setRightButton:nil title:@"取消" target:self action:@selector(touchCancelEvent)];
}

- (void)touchCancelEvent{

    [_selecteArrs removeAllObjects];
    [_selectFileStr removeAllObjects];
    [_selectDocStr removeAllObjects];

    CGRect frame = self.tableView.frame;
    frame.size.height = self.view.frame.size.height;
    self.tableView.frame = frame;
    
    _fileOperation = FileOperationNormal;
    [self.tableView reloadData];
    _operationView.hidden = YES;
    
    isManager = NO;
    
    NSDictionary *mapping = (NSDictionary*)[_paths lastObject];
    
    if (_fileOperation == FileOperationNormal) {
        _isNew = [mapping objectForKey:@"docRight"];
        if ([_isNew isEqualToString:@"true"]) {
            NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
            NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
            NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
            [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
            
        }
        else{
            [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
        }
    }
    

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_fileRightViewController.view removeFromSuperview];
}

- (NSDictionary*)fileParams:(NSString*)pathID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"", @"caseID",
                            pathID, @"classID",
                            nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"docList",@"requestKey",
                            fields,@"fields",
                            nil];
    return params;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [[_record objectForKey:@"folder_List"] count] + [[_record objectForKey:@"file_list"] count];
    return count;
}




- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:237.0/255.0 blue:254.0/255.0 alpha:1];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-10, 30)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    titleLabel.text = _pathString;
    [view addSubview:titleLabel];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isMoveDelete) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _deleteIndexPath = indexPath;
        if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
            
            NSRange range1 = [_pathString rangeOfString:@"本人承办案件文档"];
            if (range1.location != NSNotFound) {
                [self showHUDWithTextOnly:@"此文件夹不能删除"];
            }
            else{
                NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:indexPath.row];
                NSString *doc = [mapping objectForKey:@"dc_doc_class"];
                
                
                if (![_deleteHttpClient.operation isExecuting]) {
                    [_deleteHttpClient startRequest:[self deleteParams:@"" docID:doc]];
                }
            }
            
            
            
        }
        else{
            NSArray *folders = (NSArray*)[_record objectForKey:@"folder_List"];
            NSArray *files = (NSArray*)[_record objectForKey:@"file_list"];
            NSInteger index = indexPath.row - (NSInteger)folders.count;
            NSDictionary *mapping = (NSDictionary*)[files objectAtIndex:index];
            
            NSString *file = [mapping objectForKey:@"do_doc_id"];
            
            
            _isDeleting = YES;
            
            if ([self.progressHUD isHidden]) {
                
            }
            
            
            if (![_deleteHttpClient.operation isExecuting]) {
                [_deleteHttpClient startRequest:[self deleteParams:file docID:@""]];
            }
        }
        
        
        
    }
    
}


- (NSDictionary*)deleteParams:(NSString*)fileID docID:(NSString*)docID{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"pdc_doc_id",docID,@"pdc_doc_class",@"X",@"pdc_status",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"deletePrivateMultiDoc",@"requestKey",fields,@"fields", nil];
    return param;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell"];
    cell.boxButton.selected = NO;
    cell.delegate = self;
    cell.tag = indexPath.row;
    if (_fileOperation == FileOperationNormal || _fileOperation == FileOperationRead) {
        
        for (NSLayoutConstraint *layout in cell.secondView.constraints) {
            if (layout.firstItem == cell.logoImageView && layout.firstAttribute == NSLayoutAttributeLeading) {
                layout.constant = 10;
                cell.boxButton.hidden = YES;
            }
        }
        
    }
    else if (_fileOperation == FileOperationSelect){
        if (_isFileSelect) {
            if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
                for (NSLayoutConstraint *layout in cell.secondView.constraints) {
                    if (layout.firstItem == cell.logoImageView && layout.firstAttribute == NSLayoutAttributeLeading) {
                        layout.constant = 40;
                        cell.boxButton.hidden = NO;
                    }
                }
            }
            else{
                for (NSLayoutConstraint *layout in cell.secondView.constraints) {
                    if (layout.firstItem == cell.logoImageView && layout.firstAttribute == NSLayoutAttributeLeading) {
                        layout.constant = 10;
                        cell.boxButton.hidden = YES;
                    }
                }
            }
        }
        else{
            for (NSLayoutConstraint *layout in cell.secondView.constraints) {
                if (layout.firstItem == cell.logoImageView && layout.firstAttribute == NSLayoutAttributeLeading) {
                    layout.constant = 40;
                    cell.boxButton.hidden = NO;
                }
            }
        }
    }
    
    BOOL isblank = NO;
    
    if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
        NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:indexPath.row];
        cell.logoImageView.image = folderImage;
        cell.firstLabel.text = @"";
        cell.secondLabel.text = @"";
        cell.thirdLabel.text = @"";
        cell.foruthLabel.text = @"";
        
        
        
        NSString *title = [mapping safeObjectForKey:@"dc_description"];
        NSRange titleRange = [title rangeOfString:_titleKey];
        if (titleRange.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:title];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:titleRange];
            cell.titleLabel.attributedText = caseString;
        }
        else{
            cell.titleLabel.text = title;
        }
        
        for (NSDictionary *record in _selectDocStr) {
            NSString *docID = [record safeObjectForKey:@"dc_doc_class"];
            if ([docID isEqualToString:[mapping safeObjectForKey:@"dc_doc_class"]]) {
                cell.boxButton.selected = YES;
            }
            
        }
        
        if (![[mapping objectForKey:@"folderCount"] isEqualToString:@"0"]) {
            cell.firstLabel.text = [NSString stringWithFormat:@"%@个文件夹",[mapping safeObjectForKey:@"folderCount"]];
            for (NSLayoutConstraint *layout in cell.secondView.constraints) {
                
                if (layout.secondItem == cell.firstLabel && layout.secondAttribute == NSLayoutAttributeTrailing) {
                    layout.constant = 10;
                }
            }
            isblank = YES;
        }
        else{
            
            for (NSLayoutConstraint *layout in cell.secondView.constraints) {
                
                if (layout.secondItem == cell.firstLabel && layout.secondAttribute == NSLayoutAttributeTrailing) {
                    layout.constant = 0;
                }
            }
        }
        
        if (![[mapping safeObjectForKey:@"docCount"] isEqualToString:@"0"]) {
            cell.secondLabel.text = [NSString stringWithFormat:@"%@个文件",[mapping safeObjectForKey:@"docCount"]];
            isblank = YES;
        }
        
        if (!isblank) {
            cell.firstLabel.text = @"空文件夹";
        }
    }
    else{
        NSArray *folders = (NSArray*)[_record objectForKey:@"folder_List"];
        NSArray *files = (NSArray*)[_record objectForKey:@"file_list"];
        NSInteger index = indexPath.row - (NSInteger)folders.count;
        NSDictionary *mapping = (NSDictionary*)[files objectAtIndex:index];
        cell.secondLabel.text = [mapping objectForKey:@"do_filesize"];
        cell.thirdLabel.text = [mapping objectForKey:@"do_create_date"];
        cell.foruthLabel.text = [mapping objectForKey:@"do_location"];
        
        cell.logoImageView.image = [self.view checkResourceType:[mapping objectForKey:@"do_file_type"]];
        
        for (NSDictionary *record in _selectFileStr) {
            NSString *docID = [record objectForKey:@"do_doc_id"];
            if ([docID isEqualToString:[mapping objectForKey:@"do_doc_id"]]) {
                cell.boxButton.selected = YES;
            }
            
        }
        
        NSString *title = [mapping objectForKey:@"do_title"];
        NSRange titleRange = [title rangeOfString:_titleKey];
        if (titleRange.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:title];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:titleRange];
            cell.titleLabel.attributedText = caseString;
        }
        else{
            cell.titleLabel.text = title;
        }
        
        NSString *name = [mapping objectForKey:@"do_creatorName"];
        NSRange nameRange = [name rangeOfString:_nameKey];
        if (nameRange.location != NSNotFound) {
            NSMutableAttributedString *caseString = [[NSMutableAttributedString alloc] initWithString:name];
            [caseString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:nameRange];
            cell.firstLabel.attributedText = caseString;
        }
        else{
            cell.firstLabel.text = name;
        }

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
        return 60;
    }
    return 77;
}

- (void)addFileCell:(FileCell *)fileCell tag:(NSInteger)tag{
    
    if (_fileOperation == FileOperationNormal || _fileOperation == FileOperationRead) {
        if (isCut) {
            [_selectDocStr removeAllObjects];
            [_selectFileStr removeAllObjects];
            [_selecteArrs removeAllObjects];
            isCut = NO;
        }
        if (tag < [[_record objectForKey:@"folder_List"] count]) {
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:tag];
            [_selectDocStr addObject:mapping];
        }
        else{
            NSUInteger index = tag - [[_record objectForKey:@"folder_List"] count];
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"file_list"] objectAtIndex:index];
            [_selectFileStr addObject:mapping];
        }
        
        [_selecteArrs addObject:[NSNumber numberWithInteger:tag]];
        if (_selecteArrs.count > 1) {
            [self check:NO];
        }
        else{
            [self check:YES];
        }

    }
    else if (_fileOperation == FileOperationSelect){
        
        if (_isFileSelect) {
            for (int i = 0; i < [[_record objectForKey:@"folder_List"] count]; i++) {
                FileCell *cellView = (FileCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cellView.boxButton.selected = NO;
            }
            FileCell *cellView = (FileCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]];
            cellView.boxButton.selected = YES;
            
            _selectPathdic = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:tag];

        }
        else{
            if (isCut) {
                [_selectDocStr removeAllObjects];
                [_selectFileStr removeAllObjects];
                [_selecteArrs removeAllObjects];
                isCut = NO;
            }
            if (tag < [[_record objectForKey:@"folder_List"] count]) {
                NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:tag];
                [_selectDocStr addObject:mapping];
            }
            else{
                NSUInteger index = tag - [[_record objectForKey:@"folder_List"] count];
                NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"file_list"] objectAtIndex:index];
                [_selectFileStr addObject:mapping];
            }
            
            [_selecteArrs addObject:[NSNumber numberWithInteger:tag]];
            if (_selecteArrs.count > 1) {
                [self check:NO];
            }
            else{
                [self check:YES];
            }
        }
    }
}

- (void)check:(BOOL)check{
    _favoriteButton.enabled = check;
    _shareButton.enabled = check;
    _renameButton.enabled = check;
}

- (void)removeFileCell:(FileCell *)fileCell tag:(NSInteger)tag{
    if (tag < [[_record objectForKey:@"folder_List"] count]) {
        NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:tag];
        NSLog(@"1111=%ld",_selectDocStr.count);
        [_selectDocStr removeObject:mapping];
        NSLog(@"2222=%ld",_selectDocStr.count);
    }
    else{
        NSUInteger index = tag - [[_record objectForKey:@"folder_List"] count];
        NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"file_list"] objectAtIndex:index];
        
        [_selectFileStr removeObject:mapping];
    }
    
    [_selecteArrs removeObject:[NSNumber numberWithInteger:tag]];
    if (_selecteArrs.count > 1) {
        [self check:NO];
    }
    else{
        [self check:YES];
    }
    
}

- (IBAction)touchCutEvent:(id)sender{
    if (_selectDocStr.count == 0 && _selectFileStr.count == 0) {
        [self showHUDWithTextOnly:@"请选择文件或文件夹"];
        return;
    }
    
    isCut = YES;
    
    
    [self showHUDWithTextOnly:@"剪切成功"];
    _pasteHttpClient = [[HttpClient alloc] init];
    _pasteHttpClient.delegate = self;
    
}

- (IBAction)touchPasteEvent:(id)sender{
    if (_selectDocStr.count == 0 && _selectFileStr.count == 0) {
        [self showHUDWithTextOnly:@"请选择文件或文件夹"];
        return;
    }
    if (isCut) {
        isCut = NO;
        [_pasteHttpClient startRequest:[self pasteParma]];
    }
}

- (NSDictionary*)pasteParma{
    NSString *fileID = @"";
    NSString *docID = @"";
    
    for (NSDictionary *item in _selectFileStr) {
        NSString *file = [item objectForKey:@"do_doc_id"];
        fileID = [fileID stringByAppendingFormat:@"%@,",file];
    }
    
    for (NSDictionary *item in _selectDocStr){
        NSString *doc = [item objectForKey:@"dc_doc_class"];
        docID = [docID stringByAppendingFormat:@"%@,",doc];
    }
    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"do_doc_id",docID,@"do_class_id",_pathId,@"do_super_class",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"movePrivateDoc",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchRenameEvent:(id)sender{
    
    if (_selectDocStr.count == 0 && _selectFileStr.count == 0) {
        [self showHUDWithTextOnly:@"请选择文件或文件夹"];
        return;
    }
    
    _renameAlertView = [[AlertView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 155)];
    _renameAlertView.delegate = self;
    if (_selectDocStr.count == 1) {
        NSDictionary *item = (NSDictionary*)[_selectDocStr lastObject];
        [_renameAlertView showField:[item objectForKey:@"dc_description"]];
    }
    else if (_selectFileStr.count == 1){
        NSDictionary *item = (NSDictionary*)[_selectFileStr lastObject];
        [_renameAlertView showField:[item objectForKey:@"do_title"]];
    }
    _renameAlertView.tipLabel.text = @"重命名";
    _renameAlertView.alertButtonType = AlertButtonOne;
    
    [self.view addSubview:_renameAlertView];
    
}

- (void)alertView:(AlertView *)alertView field:(NSString *)text{
    if (alertView == _renameAlertView) {
        if (_selectDocStr.count == 1) {
            NSDictionary *item = (NSDictionary*)[_selectDocStr lastObject];
            NSString *strId = [item objectForKey:@"dc_doc_class"];
            [_renameHttpClient startRequest:[self renameParam:@"1" pd_doc_id:strId title:text]];
            
        }
        else if (_selectFileStr.count == 1){
            NSDictionary *item = (NSDictionary*)[_selectFileStr lastObject];
            NSString *strId = [item objectForKey:@"do_doc_id"];
            [_renameHttpClient startRequest:[self renameParam:@"0" pd_doc_id:strId title:text]];
            
        }

    }
    else if (alertView == _newDocAlertView){
        [_newDocHttpClient startRequest:[self newDocParam:text dc_is_private:_prite]];
    }
}

- (IBAction)touchCloseEvent:(id)sender{
    [_fileView removeFromSuperview];
}

- (NSDictionary*)newDocParam:(NSString*)dc_description dc_is_private:(NSString*)dc_is_private{
    NSDictionary *mapping = (NSDictionary*)[_paths lastObject];
    NSString *dc_super_class = @"";
    if (mapping) {
        dc_super_class = [mapping objectForKey:@"dc_doc_class"];
    }
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"dc_doc_class",dc_super_class,@"dc_super_class",dc_description,@"dc_description",dc_is_private,@"dc_is_private",[[CommomClient sharedInstance] getAccount],@"dc_empl_id",@"A",@"dc_status", nil];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"createFolder",@"requestKey",fields,@"fields", nil];
    return param;
}

- (IBAction)touchNewFileEvent:(id)sender{
    [self touchCloseEvent:nil];
    
    _newFileViewController = [[NewFileViewController alloc] init];
    _newFileViewController.path = _pathString;
    _newFileViewController.do_doc_class = _pathId;
    [self.navigationController pushViewController:_newFileViewController animated:YES];
}

- (IBAction)touchNewDocEvent:(id)sender{
    [self touchCloseEvent:nil];
    _newDocAlertView = [[AlertView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 155)];
    _newDocAlertView.delegate = self;
    [_newDocAlertView showField:@""];
    
    _newDocAlertView.textField.placeholder = @"请输入文件夹名称";
    _newDocAlertView.tipLabel.text = @"新建文件夹";
    _newDocAlertView.alertButtonType = AlertButtonTwo;
    
    [self.view addSubview:_newDocAlertView];
}

- (IBAction)touchFavoriteEvent:(UIButton*)sender{
//    if (sender.selected) {
//        [_cancelHttpClient startRequest:[self cancelFavoriteParan]];
//    }
//    else{
//        [_favoriteHttpClient startRequest:[self favoriteParan]];
//    }
}

//- (NSDictionary*)favoriteParan{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"case",@"collect_type",
//                         @"案件",@"collect_item_type",
//                         _caseId,@"collect_key_id",
//                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @"addCollection",@"requestKey",
//                           dic,@"fields",
//                           nil];
//    return param;
//}
//
//- (NSDictionary*)cancelFavoriteParan{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         _caseId,@"collect_key_id",
//                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           @"deleteCollection",@"requestKey",
//                           dic,@"fields",
//                           nil];
//    return param;
//}

- (IBAction)touchShareEvent:(id)sender{

}

- (IBAction)touchDeleteEvent:(id)sender{
    if (_selectDocStr.count == 0 && _selectFileStr.count == 0) {
        [self showHUDWithTextOnly:@"请选择文件或文件夹"];
        return;
    }
    [_deleteHttpClient startRequest:[self deleteParam]];
}

- (NSDictionary*)deleteParam{
    NSString *fileID = @"";
    NSString *docID = @"";
    
    for (NSDictionary *item in _selectFileStr) {
        NSString *file = [item objectForKey:@"do_doc_id"];
        fileID = [fileID stringByAppendingFormat:@"%@,",file];
    }
    
    for (NSDictionary *item in _selectDocStr){
        NSString *doc = [item objectForKey:@"dc_doc_class"];
        docID = [docID stringByAppendingFormat:@"%@,",doc];
    }

    
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:fileID,@"pdc_doc_id",docID,@"pdc_doc_class",@"X",@"pdc_status",[[CommomClient sharedInstance] getAccount],@"userID", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"deletePrivateMultiDoc",@"requestKey",fields,@"fields", nil];
    return param;
}

- (NSDictionary*)renameParam:(NSString*)isFolder pd_doc_id:(NSString*)pd_doc_id title:(NSString*)title{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:isFolder,@"isFolder",
                            pd_doc_id,@"pd_doc_id",
                            title,@"pd_description",
                            [[CommomClient sharedInstance] getAccount],@"pd_empl_id", nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"renamePrivateDoc",@"requestKey",fields,@"fields", nil];
    return param;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _titleKey = @"";
    _nameKey = @"";
    if (_fileOperation == FileOperationNormal) {
        _paper ++;
        if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:indexPath.row];
            _pathId = [mapping objectForKey:@"dc_doc_class"];
            [_paths addObject:mapping];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            NSMutableString *strPath = [[NSMutableString alloc] init];
            for (NSDictionary *mapping in _paths) {
                _selectTitle = [mapping objectForKey:@"dc_description"];
                [strPath appendFormat:@"%@/",_selectTitle];
            }
            
            if (_fileOperation == FileOperationNormal) {
                if (!isManager) {
                    _isNew = [mapping objectForKey:@"docRight"];
                    if ([_isNew isEqualToString:@"true"]) {
                        NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_add_btn.png"],@"image",nil,@"selectedImage", nil];
                        NSDictionary *secondImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"nav_right_btn.png"],@"image",nil,@"selectedImage", nil];
                        NSArray *images = [NSArray arrayWithObjects:fristImageDic,secondImageDic, nil];
                        [self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
                        
                        
                    }
                    else{
                        [self setRightButton:[UIImage imageNamed:@"nav_right_btn.png"] title:nil target:self action:@selector(touchRightEvent)];
                    }
                    
                }

            }
            
            
            NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
            if (range1.location != NSNotFound) {
                _prite = @"1";
            }
            else{
                _prite = @"0";
            }
            _pathString = strPath;
//            [self tableView:tableView viewForHeaderInSection:indexPath.section];
//            [self.tableView reloadData];
        }
        else{
             NSUInteger index = indexPath.row - [[_record objectForKey:@"folder_List"] count];
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"file_list"] objectAtIndex:index];
            
            documentViewController = [[DocumentViewController alloc] init];
            documentViewController.pathString = [mapping objectForKey:@"do_url"];
            documentViewController.type = [mapping objectForKey:@"do_file_type"];
            documentViewController.name = [mapping objectForKey:@"do_title"];
            [self.navigationController pushViewController:documentViewController animated:YES];

        }
        
        [self updateTableDelete];
        
     }
    else if (_fileOperation == FileOperationSelect){
        _paper ++;
        if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:indexPath.row];
            
            _pathId = [mapping objectForKey:@"dc_doc_class"];
            [_paths addObject:mapping];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            NSMutableString *strPath = [[NSMutableString alloc] init];
            for (NSDictionary *mapping in _paths) {
                _selectTitle = [mapping objectForKey:@"dc_description"];
                [strPath appendFormat:@"%@/",_selectTitle];
            }
            
            if (_titleStr.length > 0) {
                _pathString = [NSString stringWithFormat:@"%@%@",_titleStr,strPath];
            }
            else{
                _pathString = strPath;
            }
            
            
            //[self tableView:tableView viewForHeaderInSection:indexPath.section];
//            [self.tableView reloadData];
            
            NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
            if (range1.location != NSNotFound) {
                _prite = @"1";
            }
            else{
                _prite = @"0";
            }
            
            
        }

    }
    else if (_fileOperation == FileOperationRead) {
        _paper ++;
        if (indexPath.row < [[_record objectForKey:@"folder_List"] count]) {
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"folder_List"] objectAtIndex:indexPath.row];
            
            _pathId = [mapping objectForKey:@"dc_doc_class"];
            [_paths addObject:mapping];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            NSMutableString *strPath = [[NSMutableString alloc] init];
            for (NSDictionary *mapping in _paths) {
                _selectTitle = [mapping objectForKey:@"dc_description"];
                [strPath appendFormat:@"%@/",_selectTitle];
            }
            _pathString = [NSString stringWithFormat:@"%@%@",_titleStr,strPath];
            //[self tableView:tableView viewForHeaderInSection:indexPath.section];
            //            [self.tableView reloadData];
            
            NSRange range1 = [_pathString rangeOfString:@"我的个人文档"];
            if (range1.location != NSNotFound) {
                _prite = @"1";
            }
            else{
                _prite = @"0";
            }
            
            
        }
        else{
            NSUInteger index = indexPath.row - [[_record objectForKey:@"folder_List"] count];
            NSDictionary *mapping = (NSDictionary*)[[_record objectForKey:@"file_list"] objectAtIndex:index];
            
            documentViewController = [[DocumentViewController alloc] init];
            documentViewController.pathString = [mapping objectForKey:@"do_url"];
            documentViewController.type = [mapping objectForKey:@"do_file_type"];
            documentViewController.name = [mapping objectForKey:@"do_title"];
            [self.navigationController pushViewController:documentViewController animated:YES];

        }
    }
    
}

- (void)touchNavRight:(UIButton*)button{
    if (button.tag == 0) {
         _fileView.frame = [UIScreen mainScreen].bounds;
        [self.navigationController.view addSubview:_fileView];
    }
    else if (button.tag == 1){
        [self touchRightEvent];
    }
    
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
    [self.view bringSubviewToFront:self.progressHUD];
}

- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];

    if (request == _listHttpClient) {
        _record = (NSDictionary*)responseObject;
        [self.topRefreshIndicator didLoadComplete:nil];

        if (_fileState == FileStateSearch) {
            if ([[_record objectForKey:@"folder_List"] count] == 0 &&  [[_record objectForKey:@"file_list"] count] == 0) {
                [self showHUDWithTextOnly:@"无相关数据"];
            }
        }
    }
    else if (request == _renameHttpClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"操作成功"];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            [_selectDocStr removeAllObjects];
            [_selectFileStr removeAllObjects];
            [_selecteArrs removeAllObjects];
            
        }
        else{
            [self showHUDWithTextOnly:@"操作失败"];
        }
    }
    else if (request == _pasteHttpClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"粘贴成功"];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            [_selectDocStr removeAllObjects];
            [_selectFileStr removeAllObjects];
            [_selecteArrs removeAllObjects];
            isCut = NO;
        }
        else{
            [self showHUDWithTextOnly:@"粘贴失败"];
        }
    }
    else if (request == _deleteHttpClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"删除成功"];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            [_selectDocStr removeAllObjects];
            [_selectFileStr removeAllObjects];
            [_selecteArrs removeAllObjects];
            isCut = NO;
        }
        else{
            [self showHUDWithTextOnly:@"删除失败"];
        }
    }
    else if (request == _newDocHttpClient){
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"创建文件夹成功"];
            [_listHttpClient startRequest:[self fileParams:_pathId]];
            [_selectDocStr removeAllObjects];
            [_selectFileStr removeAllObjects];
            [_selecteArrs removeAllObjects];
            isCut = NO;
        }
        else{
            [self showHUDWithTextOnly:@"创建文件夹失败"];
        }
    }
    [self.tableView reloadData];
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
