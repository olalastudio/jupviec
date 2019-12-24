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
    
    _locationManager = [[CLLocationManager alloc] init];
    
    [_locationManager setDelegate:self];
    [_mapView setDelegate:self];
    [_txtAddress setDelegate:self];
}

- (IBAction)didPressConfirmLocationButton:(id)sender
{
    if ([[_txtAddress text] isEqualToString:@""] || [_txtAddress text] == nil)
    {
        return;
    }
    
    PlaceOrderViewController *placeview;
    
    for (UIViewController *vc in [self.navigationController viewControllers])
    {
        if ([vc isKindOfClass:[PlaceOrderViewController class]])
        {
            placeview = (PlaceOrderViewController*)vc;
            [placeview setCurrentLocation:selectedLocation];
        }
    }
    
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
            [self.txtAddress setText:[lines componentsJoinedByString:@"\n"]];

            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
        } else
            return;
    }];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
