//
//  MapsViewController.h
//  JupViec
//
//  Created by KienVu on 12/9/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapsViewController : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate>
{
    CLLocationManager* _locationManager;
    GMSMarker* _locationMaker;
    BOOL _isShowLocationMaker;
}

@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;


@end

NS_ASSUME_NONNULL_END
