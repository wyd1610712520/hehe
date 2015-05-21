//
//  ClientDocViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-10-8.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CommomTableViewController.h"

#import "ClientDocCell.h"



@interface ClientDocViewController : CommomTableViewController

@property (nonatomic, strong) IBOutlet ClientDocCell *clientDocCell;
@property (nonatomic, strong) NSString *clientID;

@end
