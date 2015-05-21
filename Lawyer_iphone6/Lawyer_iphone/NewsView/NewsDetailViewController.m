//
//  NewsDetailViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "FileView.h"

#import "ClientDocCell.h"

#import "CommomClient.h"

#import "UIImageView+AFNetworking.h"

#import "DocumentViewController.h"

@interface NewsDetailViewController ()<RequestManagerDelegate,UITableViewDataSource,UITableViewDelegate>{
    HttpClient *_detailHttpClient;
    NSArray *_files;
    
    HttpClient *_favoriteHttpClient;
    HttpClient *_cancelHttpClient;
    
    UIButton *_favoriteButton;
    
    ClientDocCell *_clientDocCell;
    
    DocumentViewController *documentViewController;
}

@end

@implementation NewsDetailViewController

@synthesize newType = _newType;
@synthesize key = _key;
@synthesize record = _record;
@synthesize contentView = _contentView;

@synthesize tableView = _tableView;

@synthesize attachButton = _attachButton;

@synthesize titleLabel = _titleLabel;
@synthesize dateLabel = _dateLabel;
@synthesize typeLabel = _typeLabel;
@synthesize contentLabel = _contentLabel;
@synthesize imageView = _imageView;
@synthesize attachLabel = _attachLabel;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_newType == NewTypeNews) {
        [self setTitle:[Utility localizedStringWithTitle:@"news_detail_nav_title"] color:nil];
    }
    else if (_newType == NewTypeNotice){
        [self setTitle:@"公告详情" color:nil];
    }
    
    [_detailHttpClient startRequest:[self param:_key]];
    self.navigationController.navigationBar.translucent = NO;
}

- (NSDictionary*)param:(NSString*)key{
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            [[CommomClient sharedInstance] getAccount], @"userID",
                            _titleID,@"paperID",
                            nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            key,@"requestKey",
                            fields,@"fields",nil];
    return params;
}

- (IBAction)touchAttachEvent:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        [_scroll setContentOffset:CGPointMake(0, _attachLabel.frame.origin.y)];
    }];
    
}

- (void)touchNavRight:(UIButton*)button{
    if (button.selected) {
        [_cancelHttpClient startRequest:[self cancelFavoriteParan]];
    }
    else{
        if (_newType == NewTypeNews) {
            [_favoriteHttpClient startRequest:[self favoriteParan:@"新闻"]];
        }
        else if (_newType == NewTypeNotice){
            [_favoriteHttpClient startRequest:[self favoriteParan:@"公告"]];
        }
        
    }
}

- (NSDictionary*)favoriteParan:(NSString*)type{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"bulletin",@"collect_type",
                         type,@"collect_item_type",
                         _titleID,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"addCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (NSDictionary*)cancelFavoriteParan{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         _titleID,@"collect_key_id",
                         [[CommomClient sharedInstance] getAccount],@"userID",nil];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"deleteCollection",@"requestKey",
                           dic,@"fields",
                           nil];
    return param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary *fristImageDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"favorite_normal.png"],@"image",[UIImage imageNamed:@"favorite_selected.png"],@"selectedImage", nil];
    
    NSArray *images = [NSArray arrayWithObjects:fristImageDic, nil];
    _favoriteButton =[self setNavigationSegmentWithImages:images target:self action:@selector(touchNavRight:)];
    
    _detailHttpClient = [[HttpClient alloc] init];
    _detailHttpClient.delegate = self;
    
    _favoriteHttpClient = [[HttpClient alloc] init];
    _favoriteHttpClient.delegate = self;
    
    _cancelHttpClient = [[HttpClient alloc] init];
    _cancelHttpClient.delegate = self;
    
//    UINib *nib = [UINib nibWithNibName:@"ClientDocCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"ClientDocCell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _clientDocCell = [[ClientDocCell alloc] init];
}

#pragma mark - RequestManagerDelegate

- (void)requestStarted:(id)request{
    [self showProgressHUD:@""];
}


- (void)request:(id)request didCompleted:(id)responseObject{
    [self hideProgressHUD:0];
    NSDictionary *dic = (NSDictionary*)responseObject;

   
    
    if (request == _favoriteHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"收藏成功"];
            _favoriteButton.selected = YES;
        }
        else{
            [self showHUDWithTextOnly:@"收藏失败"];
            _favoriteButton.selected = NO;
        }
    }
    else if (request == _cancelHttpClient){
        if ([[dic objectForKey:@"mgid"] isEqualToString:@"true"]) {
            [self showHUDWithTextOnly:@"取消收藏成功"];
            _favoriteButton.selected = NO;
        }
        else{
            [self showHUDWithTextOnly:@"取消失败"];
            _favoriteButton.selected = YES;
        }
    }
    else if (request == _detailHttpClient){
        
        
        
        NSDictionary *record = (NSDictionary*)[dic objectForKey:@"record"];
        _files = [record objectForKey:@"file_list"];
        
        [_attachButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_files.count] forState:UIControlStateNormal];
        
        if (_files.count == 0) {
            _attachButton.hidden = YES;
            _attachLabel.hidden = YES;
        }
        
        NSString *titleImport = @"【重要】";
        NSString *title = [record objectForKey:@"blt_title"];
        
        if (![[record objectForKey:@"blt_is_important"] isEqualToString:@"False"]) {
            titleImport = [titleImport stringByAppendingFormat:@"%@",title];
            NSRange range = [titleImport rangeOfString:@"【重要】"];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:titleImport];
                [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
                _titleLabel.attributedText = string;
            }

        }
        else{
            _titleLabel.text = title;
        }
        

        if ([[record objectForKey:@"blt_iscollect"] isEqualToString:@"0"]) {
            _favoriteButton.selected = NO;
        }
        else{
            _favoriteButton.selected = YES;
        }
        
        _dateLabel.text = [record objectForKey:@"blt_date"];
        _typeLabel.text = [record objectForKey:@"blt_type"];
        
        NSString *imageUrl = [record objectForKey:@"blt_imgfile"];
        if (imageUrl.length == 0) {
            for (NSLayoutConstraint *layout in _imageView.constraints) {
                if (layout.firstAttribute == NSLayoutAttributeHeight) {
                    layout.constant = 0;
                }
            }
        }
        else{
            [_imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
        
        NSString *content  = [record objectForKey:@"blt_content"];
        
        
        UIFont *font = [UIFont systemFontOfSize:17];
        CGSize size = CGSizeMake(_contentLabel.frame.size.width, 2000);
        
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:content];
        NSDictionary *textAttributes = @{NSFontAttributeName: font};
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        [style setLineSpacing:10.0f];
        
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [content length])];
        
        _contentLabel.attributedText = attStr;
        [_contentView sizeToFit];
        
        CGRect labelsize = [[record objectForKey:@"blt_content"] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];

        
        for (NSLayoutConstraint *layout in _contentView.constraints) {
            if (layout.firstItem == _contentView && layout.firstAttribute == NSLayoutAttributeHeight) {
                layout.constant = 800+labelsize.size.height*1.1+_files.count*70;
            }
        }
        
        for (NSLayoutConstraint *layout in _tableView.constraints) {
            if (layout.firstItem == _tableView && layout.firstAttribute == NSLayoutAttributeHeight) {
                layout.constant = _files.count*70;
            }
        }

        [self.tableView reloadData];
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClientDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClientDocCell"];
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"ClientDocCell" owner:self options:nil];
        cell = _clientDocCell;
    }
    NSDictionary *dic = (NSDictionary*)[_files objectAtIndex:indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"attachment_title"];
    cell.logoImageView.image = [self.view checkResourceType:[dic objectForKey:@"attachment_type"]];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = (NSDictionary*)[_files objectAtIndex:indexPath.row];
    NSString *path = [dic objectForKey:@"attachment_url"];
    NSString *type = [dic objectForKey:@"attachment_type"];
    documentViewController = [[DocumentViewController alloc] init];
    
    if (path.length > 0 && type.length > 0) {
        documentViewController.pathString = path;
        documentViewController.type = type;
        documentViewController.name = [dic objectForKey:@"attachment_title"];
        [self.navigationController pushViewController:documentViewController animated:YES];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)requestFailed:(id)request{
    [self hideProgressHUD:0];
}



@end
