//
//  MapViewController.h
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "CustomNavigationViewController.h"

#import <MapKit/MapKit.h>

@class MapViewController;

@protocol MapViewControllerDelegate  <NSObject>

- (void)returnUserLocation:(NSString*)address;

@end

@interface MapViewController : CustomNavigationViewController

@property (nonatomic, strong) NSObject<MapViewControllerDelegate> *delegate;

@property (nonatomic, strong) NSString *address;
- (void)search;
- (void)location;

@end
