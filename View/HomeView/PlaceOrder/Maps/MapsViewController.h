//
//  MapsViewController.h
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapsViewController : JViewController <CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager* _locationManager;
    GMSMarker* _locationMaker;
    BOOL _isShowLocationMaker;
}

@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btConfirmLocation;

- (IBAction)didPressConfirmLocationButton:(id)sender;

-(void)setSelectedLocation:(CLLocationCoordinate2D)location;

@end

NS_ASSUME_NONNULL_END
