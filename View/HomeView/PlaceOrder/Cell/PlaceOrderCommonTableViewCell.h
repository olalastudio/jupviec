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
#import <FTPopOverMenu/FTPopOverMenu.h>

@class Order;

@protocol PlaceOrderCommonCellProtocol <NSObject>

-(void)didPressCellAtIndexPath:(NSIndexPath*_Nonnull)index attributeType:(ORDER_ATTRIBUTE)attribute;
-(void)didSelectPaymentMethod:(NSDictionary*_Nonnull)code index:(NSIndexPath*_Nonnull)index;
-(void)didSelectExtentService:(NSDictionary*_Nonnull)code index:(NSIndexPath*_Nonnull)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderCommonTableViewCell : UITableViewCell <UITextViewDelegate>
{
    ORDER_ATTRIBUTE     _ordeAttribute;
    NSIndexPath         *_indexPath;
    Order               *_order;
    NSDictionary        *_serviceInfo;
}

@property id<PlaceOrderCommonCellProtocol>      delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute;
-(ORDER_ATTRIBUTE)orderAttribute;

-(void)setIndexPath:(NSIndexPath*)index;
-(NSIndexPath*)indexPath;

-(void)setOrder:(Order*)order;

-(void)setServiceInfo:(NSDictionary*)serviceInfo;
-(NSDictionary*)serviceInfo;

-(void)reloadViewContent;
@end

NS_ASSUME_NONNULL_END
