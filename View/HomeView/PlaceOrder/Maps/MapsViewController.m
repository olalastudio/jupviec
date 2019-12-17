//
//  MapsViewController.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "MapsViewController.h"
#import "PlaceOrderViewController.h"

@interface MapsViewController ()
{
    CLLocationCoordinate2D selectedLocation;
}

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isShowLocationMaker = NO;
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager requestWhenInUseAuthorization];
    [_mapView setDelegate:self];
}

- (IBAction)didPressConfirmLocationButton:(id)sender
{
    NSArray *viewcontrollers = [self.navigationController viewControllers];
    
    PlaceOrderViewController *placeview = (PlaceOrderViewController*)viewcontrollers[viewcontrollers.count - 3];
    [placeview setCurrentLocation:selectedLocation];
    
    [self.navigationController popToViewController:placeview animated:YES];
}

#pragma mark - LocationDelegate
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        [_locationManager startUpdatingLocation];
        [_mapView setMyLocationEnabled:YES];
        [_mapView.settings setMyLocationButton:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location = [locations firstObject];
    _mapView.camera = [[GMSCameraPosition alloc]initWithTarget:location.coordinate zoom:15 bearing:0 viewingAngle:0];
    [_locationManager stopUpdatingLocation];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    _locationMaker.map = nil;
    [self reverseGeocodeCoordinate:coordinate];
    [self setupLocationMaker:coordinate];
    
    selectedLocation = coordinate;
}

- (void)setupLocationMaker:(CLLocationCoordinate2D)coordinate
{
        _locationMaker = [GMSMarker markerWithPosition:coordinate];
        _locationMaker.map = _mapView;
        _locationMaker.appearAnimation = kGMSMarkerAnimationPop;
        _locationMaker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
        _locationMaker.opacity = 0.75;
}

- (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)locationCoordinate
{
    GMSGeocoder*  geocoder = [[GMSGeocoder alloc]init];
    [geocoder reverseGeocodeCoordinate:locationCoordinate completionHandler:^(GMSReverseGeocodeResponse * _Nullable response, NSError * _Nullable error) {
        if (response)
        {
            GMSAddress* address = [response firstResult];
            NSArray* lines = [address lines];
            [self.addressLb setText:[lines componentsJoinedByString:@"\n"]];
//            NSInteger labelHeight = self.addressLb.intrinsicContentSize.height;
//            self.mapView.padding = UIEdgeInsetsMake(self.view.safeAreaInsets.top, 0, labelHeight, 0);
            [UIView animateWithDuration:0.25 animations:^{
                
                [self.view layoutIfNeeded];
            }];
        } else
            return;
    }];
}

@end
