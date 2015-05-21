//
//  ProcessCommentCell.m
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-2.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "ProcessCommentCell.h"
#import "NSString+Utility.h"

#import "LineView.h"

@implementation ProcessCommentCell

@synthesize avatorButton = _avatorButton;
@synthesize nameLabel = _nameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize contentLabel = _contentLabel;

ProcessCommentCell *cell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString*)content files:(NSArray *)files{
     _contentLabel.text = content;
//    [_contentLabel sizeToFit];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-65, 10000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];

    
    float y = labelsize.origin.y+labelsize.size.height+50;
    int i = 1;
    
     
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[CommentFileView class]]) {
            [subView removeFromSuperview];
        }

    }
    

    for (NSDictionary *item in files) {
        CommentFileView *fileView = [[CommentFileView alloc] initWithFrame:CGRectMake(_contentLabel.frame.origin.x, y+(i-1)*60 , [UIScreen mainScreen].bounds.size.width - 49, 60)];
        [self addSubview:fileView];
        
        
        
        fileView.tag = self.tag;
        fileView.operationButton.tag = i-1;
        
        if (i == files.count) {
            fileView.lineView.hidden = YES;
        }
        
        if (i == 1) {
            _firstView = fileView;
        }
        
        i++;

        if (_isAllRight) {
            [fileView setOperationHide:NO];
        }
        else{
            [fileView setOperationHide:YES];
        }
        
        
        
        fileView.logoImageView.image = [cell checkResourceType:[item objectForKey:@"cpa_file_type"]];
        fileView.titleLabel.text = [item objectForKey:@"cpa_file_name"];
        fileView.nameLabel.text = [item objectForKey:@"cpa_creator_name"];
        fileView.dateLabel.text = [item objectForKey:@"cpa_create_date"];
        
        if ([[item objectForKey:@"cpa_doc_dir"] length] > 0) {
            fileView.operationButton.hidden = YES;
        }
        else{
            fileView.operationButton.hidden = NO;
        }
    }
}


+ (CGFloat)heightForRow:(NSString*)content files:(NSArray *)files{
    cell = [self loadCell];
    CGFloat height = 70;
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width-59, 10000);
    
    NSDictionary *textAttributes = @{NSFontAttributeName: font};
    
    
    CGRect labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    height = height + labelsize.size.height+files.count*60;
   
    return height;
}

+ (id)loadCell{
    NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"ProcessCommentCell" owner:self options:nil];
    return [cells objectAtIndex:0];
}

- (void)touchDeleteBtn:(id)btn
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchDelete" object:_deleteBtn];
}

@end


@implementation CommentFileView

@synthesize logoImageView;
@synthesize nameLabel;
@synthesize titleLabel;
@synthesize dashLineView;
@synthesize dateLabel;
@synthesize operationButton;

@synthesize lineView = _lineView;

- (void)touchViewEvent{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchce" object:operationButton];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewEvent)];
        [self addGestureRecognizer:tap];
        
        logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height-40)/2, 40, 40)];
        [self addSubview:logoImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, logoImageView.frame.origin.y, frame.size.width-105, 17)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, titleLabel.frame.size.height+titleLabel.frame.origin.y+8, 48, 15)];
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, nameLabel.frame.origin.y, 70, 16)];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:dateLabel];
        
        operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [operationButton setImage:[UIImage imageNamed:@"zhuancun.png"] forState:UIControlStateNormal];
        //[operationButton setTitle:@"转存" forState:UIControlStateNormal];
        [operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        operationButton.titleLabel.font = [UIFont systemFontOfSize:13];
        operationButton.tag = self.tag;
        operationButton.frame = CGRectMake(frame.size.width-56, (frame.size.height-30)/2, 46, 30);
        [self addSubview:operationButton];
        [operationButton addTarget:self action:@selector(touchOperationEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 0.5)];
        _lineView.backgroundColor = [@"#dddddd" colorValue];
        [self addSubview:_lineView];
//        dashLineView = [[DashLineView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
//        [self addSubview:dashLineView];
        
    }
    return self;
}

- (void)setOperationHide:(BOOL)hide{
    
    CGRect frame = titleLabel.frame;
    if (hide) {
        frame.size.width = self.frame.size.width-55;
    }
    else{
        frame.size.width = self.frame.size.width-105;
    }
    titleLabel.frame = frame;
    
    operationButton.hidden = hide;
}


- (void)touchOperationEvent:(UIButton*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touch" object:operationButton];
}

@end