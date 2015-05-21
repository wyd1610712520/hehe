//
//  NewsViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-11-6.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

typedef enum {
    NewTypeNews = 1,
    NewTypeNotice = 2,
}NewType;

@interface NewsViewController : CommomTableViewController



@property (nonatomic, assign) NewType newType;

@end
