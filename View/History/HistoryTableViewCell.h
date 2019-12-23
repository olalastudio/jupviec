//
//  HistoryTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "JUntil.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableViewCell : UITableViewCell
{
    NSDictionary     *_definesCode;
}

@property (strong, nonatomic) NSDictionary *historyData;

@property (weak, nonatomic) IBOutlet UILabel *txtStatus;
@property (weak, nonatomic) IBOutlet UILabel *txtDate;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgAddress;
@property (weak, nonatomic) IBOutlet UILabel *txtWorkAddress;
@property (weak, nonatomic) IBOutlet UILabel *txtTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *txtClientStatus;

-(void)setDefineCodeGetFromServer:(NSMutableDictionary*)codes;

@end

NS_ASSUME_NONNULL_END
