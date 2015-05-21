//
//  MapViewController.m
//  Law_Iphone
//
//  Created by 邬 明 on 14-12-29.
//  Copyright (c) 2014年 邬 明. All rights reserved.
//

#import "MapViewController.h"

#import <MAMapKit/MAMapKit.h>

#import <AMapSearchKit/AMapSearchAPI.h>


@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    MAMapView *_mapView;
    
    AMapSearchAPI *_search;
    
    BOOL isShowLocatoion;
    
    NSString *_userAddress;
    
    AMapReGeocodeSearchRequest *request;
}

@end

@implementation MapViewController

@synthesize address = _address;
@synthesize delegate = _delegate;

- (void)search{
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"ccbc5fd90f5b151252047c9b5cd36331" Delegate:self];
    _search.language = AMapSearchLanguage_zh_CN;
    
    
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceKeyword;
    poiRequest.keywords = _address;
    poiRequest.requireExtension = YES;
    
    //发起POI搜索
    [_search AMapPlaceSearch: poiRequest];
    
    [self showProgressHUD:@"请稍后"];
}

- (void)location{
    isShowLocatoion = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_delegate) {
        [self setRightButton:nil title:@"确定" target:self action:@selector(touchSureEvent)];
    }
}

- (void)touchSureEvent{
    if ([_delegate respondsToSelector:@selector(returnUserLocation:)]) {
        [_delegate returnUserLocation:_userAddress];
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    [self hideProgressHUD:0];
    if(response.pois.count == 0)
    {
        return;
    }

    AMapPOI *p = (AMapPOI*)[response.pois lastObject];
    
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(p.location.latitude,p.location.longitude);
     [_mapView setCenterCoordinate:coords animated:YES];
    
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = coords;
    
    [_mapView addAnnotation:annotation];
    
    

}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        
        request.searchType = AMapSearchType_ReGeocode;
        request.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        request.radius = 10000;
        request.requireExtension = YES;
        [_search AMapReGoecodeSearch:request];
    }
}


- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response{
    
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if (response.regeocode != nil) {

        if (response.regeocode.formattedAddress.length > 0) {
            _userAddress = response.regeocode.formattedAddress;
            
        }
    }
}

- (void)searchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"error=%@",error);
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    _search = [[AMapSearchAPI alloc] initWithSearchKey:@"ccbc5fd90f5b151252047c9b5cd36331" Delegate:self];
    _search.language = AMapSearchLanguage_zh_CN;
    request = [[AMapReGeocodeSearchRequest alloc] init];
    
    
    [MAMapServices sharedServices].apiKey = @"ccbc5fd90f5b151252047c9b5cd36331";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    if (isShowLocatoion) {
        _mapView.showsUserLocation = YES;
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    MAAnnotationView *view = views[0];
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.image =[UIImage imageNamed:@"red_location.png"];
        
        
        [_mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointZero;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        annotationView.image = [UIImage imageNamed:@"red_location.png"];
        
        return annotationView;
    }
    
    return nil;
}

@end
