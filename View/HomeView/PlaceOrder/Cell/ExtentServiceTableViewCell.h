//
//  ExtentServiceTableViewCell.h
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceCell.h"
#import "CommonDefines.h"
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ExtendServiceCellDelegate <NSObject>

-(void)didPressAddExtentService:(NSDictionary*_Nonnull)code index:(NSIndexPath*_Nonnull)index;

@end

@interface ExtentServiceTableViewCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
}

@property id<ExtendServiceCellDelegate>             delegate;
@property (weak, nonatomic) IBOutlet UILabel        *txtTitle;
@property (weak, nonatomic) IBOutlet UIButton       *btAdd;
@property (weak, nonatomic) IBOutlet UITableView    *tbService;

- (IBAction)didPressAddMoreExtendService:(id)sender;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

@end

NS_ASSUME_NONNULL_END
