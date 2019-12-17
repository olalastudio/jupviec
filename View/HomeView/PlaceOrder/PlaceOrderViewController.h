//
//  PlaceOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "Order.h"
#import "PlaceOrderCommonTableViewCell.h"
#import "TimeSelectionTableViewCell.h"
#import "DaySelectionTableViewCell.h"
#import "ChooseAddressViewController.h"
#import "TextDetailPopupController.h"
#import "DateTimePickerPopupController.h"
#import "APIRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PlaceOrderCommonCellProtocol, TextDetailPopupDelegate,DateTimePickerDelegate, TimeSelectionTableViewCellDelegate,DaySelectionTableViewCellDelegate>
{
    TASK_TYPE       _tasktype;
    Order           *_order;
}

@property (weak, nonatomic) IBOutlet UITableView *tbPlaceOrderContent;
@property (strong, nonatomic) NSDictionary* serviceInfo;
@property Order     *order;

-(void)setTaskType:(TASK_TYPE)type;
-(void)setCurrentLocation:(CLLocationCoordinate2D)currentlocation;

@end

NS_ASSUME_NONNULL_END
