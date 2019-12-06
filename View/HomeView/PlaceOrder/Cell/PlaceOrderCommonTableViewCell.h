//
//  PlaceOrderCommonTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import <CoreLocation/CoreLocation.h>

@protocol PlaceOrderCommonCellProtocol <NSObject>

-(void)didPressSelectLocation:(CLLocation*_Nullable)currentLocation;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderCommonTableViewCell : UITableViewCell
{
    ORDER_ATTRIBUTE     _ordeAttribute;
}

@property id<PlaceOrderCommonCellProtocol>      delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtContent;


-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
@end

NS_ASSUME_NONNULL_END