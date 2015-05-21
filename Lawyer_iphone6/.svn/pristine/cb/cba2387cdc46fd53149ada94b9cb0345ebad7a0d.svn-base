//
//  CaseDescribeViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-28.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CaseDescribeViewController.h"

@interface CaseDescribeViewController (){
    UIScrollView *_scrollView;
    
}

@end

@implementation CaseDescribeViewController

@synthesize content = _content;
@synthesize titleLabel = _titleLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"案情简介" color:nil];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, self.view.frame.size.height-20)];
    _titleLabel.text = _content;
    _titleLabel.textColor = [UIColor blackColor];
    [_scrollView addSubview:_titleLabel];
    _titleLabel.numberOfLines = 0;
   
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:8];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_content length])];
    _titleLabel.attributedText = attributedString;
    
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _titleLabel.frame.size.height+100)];
     [_titleLabel sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
