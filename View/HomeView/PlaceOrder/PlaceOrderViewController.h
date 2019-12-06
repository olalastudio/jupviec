//
//  PlaceOrderViewController.h
//  JupViec
//
//  Created by KienVu on 12/5/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "PlaceOrderCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, PlaceOrderCommonCellProtocol>
{
    TASK_TYPE _tasktype;
}

@property (weak, nonatomic) IBOutlet UITableView *tbPlaceOrderContent;

-(void)setTaskType:(TASK_TYPE)type;

@end

NS_ASSUME_NONNULL_END
