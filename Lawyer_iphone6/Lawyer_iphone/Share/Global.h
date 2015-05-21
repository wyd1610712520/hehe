//
//  Global.h
//  Lawyer_iphone
//
//  Created by 邬 明 on 15-1-6.
//  Copyright (c) 2015年 邬 明. All rights reserved.
//

#import <Foundation/Foundation.h>

#define backviewTag 110
#define vector_x  [UIScreen mainScreen].bounds.size.width * 0.91
#define vectorx [UIScreen mainScreen].bounds.size.width * 0.09
#define scale_x 0.77
#define animationTime 0.4


#define unIphone4 ([[UIScreen mainScreen] bounds].size.height > 480 ? YES : NO)

#define Iphone6 ([[UIScreen mainScreen] bounds].size.width == 375 ? YES : NO)

#define Iphone6s ([[UIScreen mainScreen] bounds].size.width == 414 ? YES : NO)