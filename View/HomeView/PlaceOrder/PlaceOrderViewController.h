//
//  PlaceOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"
#import "Order.h"
#import "User.h"
#import "PlaceOrderCommonTableViewCell.h"
#import "TimeSelectionTableViewCell.h"
#import "DaySelectionTableViewCell.h"
#import "MapsViewController.h"
#import "TextDetailPopupController.h"
#import "DateTimePickerPopupController.h"
#import "APIRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderViewController : JViewController <UITableViewDelegate, UITableViewDataSource, PlaceOrderCommonCellProtocol, TextDetailPopupDelegate,DateTimePickerDelegate, TimeSelectionTableViewCellDelegate,DaySelectionTableViewCellDelegate, UIActionSheetDelegate>
{
    TASK_TYPE       _tasktype;
    Order           *_order;
    User            *_user;
    CLLocationCoordinate2D  _location;
}

@property (strong, nonatomic) NSDictionary* serviceInfo;
@property Order     *order;
@property User      *user;

@property (weak, nonatomic) IBOutlet UITableView *tbPlaceOrderContent;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoneyValue;
@property (weak, nonatomic) IBOutlet UIButton *btNext;

-(void)setTaskType:(TASK_TYPE)type;
-(void)setCurrentLocation:(CLLocationCoordinate2D)currentlocation;

- (IBAction)didPressNextToConfirmOrder:(id)sender;

@end

NS_ASSUME_NONNULL_END
