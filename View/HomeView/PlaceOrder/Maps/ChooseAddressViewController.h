//
//  ChooseAddressViewController.h
//  JupViec
//
//  Created by Khanhlt on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseAddressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    NSMutableArray* _filteredFullAddressArr;
    NSMutableArray* _filteredPrimaryAddressArr;
    BOOL shouldShowSearchResult;
    GMSPlacesClient* _placesClient;
}
@property (weak, nonatomic) IBOutlet UISearchBar *addressSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@end

NS_ASSUME_NONNULL_END
