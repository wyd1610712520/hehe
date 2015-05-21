//
//  DocumentViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 15-1-3.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

@class DocumentViewController;

@protocol DocumentViewControllerDelegate <NSObject>
@optional
- (void)closeDocument;

@end

typedef enum {
    DocumentTypeWeb = 0,
    DocumentTypeLocal = 1,
}DocumentType;

@interface DocumentViewController : CustomNavigationViewController

@property (nonatomic, assign) DocumentType documentType;

@property (nonatomic, strong) NSObject<DocumentViewControllerDelegate> *delegate;


@property (nonatomic, strong) NSString *pathString;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSData *data;

@end
