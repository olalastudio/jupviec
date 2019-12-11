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

@class Order;

@protocol PlaceOrderCommonCellProtocol <NSObject>

-(void)didPressCellAtIndexPath:(NSIndexPath*_Nonnull)index attributeType:(ORDER_ATTRIBUTE)attribute;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderCommonTableViewCell : UITableViewCell <UITextViewDelegate>
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
}

@property id<PlaceOrderCommonCellProtocol>      delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

-(void)reloadViewContent;
@end

NS_ASSUME_NONNULL_END
