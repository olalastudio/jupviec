//
//  MapsViewController.m
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "MapsViewController.h"
#import "CommonDefines.h"
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
    [_txtAddress setDelegate:self];
    
    [_mapView setDelegate:self];
    
    _mapView.layer.cornerRadius = 10;
    _mapView.layer.borderWidth = 1;
    _mapView.layer.borderColor = [UIColor colorWithRed:210.0f/255.0f green:218.0f/255.0f blue:218.0f/255.0f alpha:0.51].CGColor;

    [_txtMapTitle setTextColor:[UIColor blackColor]];
    [_txtAddressTitle setTextColor:[UIColor blackColor]];
    
    [self setTitle:@"Bản đồ"];
    self.view.layer.masksToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (selectedLocation.latitude != 0 && selectedLocation.longitude != 0)
    {
        [self reverseGeocodeCoordinate:selectedLocation];
        [self setupLocationMaker:selectedLocation];
    }
    else
    {
        [_locationManager requestLocation];
    }
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
            [placeview setLocation:[_txtAddress text] coordinate:selectedLocation];
        }
    }
    
    [self.navigationController popToViewController:placeview animated:YES];
}

-(void)setSelectedLocation:(CLLocationCoordinate2D)location
{
    selectedLocation = location;
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
    selectedLocation = location.coordinate;
    
    _locationMaker.map = nil;
    _mapView.camera = [[GMSCameraPosition alloc] initWithTarget:selectedLocation zoom:15 bearing:0 viewingAngle:0];
    
    [self reverseGeocodeCoordinate:selectedLocation];
    [self setupLocationMaker:selectedLocation];
    
    [_locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"request location did fail with error %@",error);
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
