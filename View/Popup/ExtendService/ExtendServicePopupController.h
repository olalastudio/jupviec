//
//  ExtendServicePopupController.h
//  JupViec
//
//  Created by KienVu on 1/9/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "CommonDefines.h"

@class JButton;
@class PopupView;

NS_ASSUME_NONNULL_BEGIN
@protocol ExtendServicePopupDelegate <NSObject>

-(void)didSelectExtendService:(ORDER_ATTRIBUTE)sender indexPath:(NSIndexPath*)index services:(NSArray*)services;

@end

@interface ExtendServicePopupController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray     *_totalservice;
    NSMutableArray     *_selectedservice;
    
    ORDER_ATTRIBUTE _orderAttribute;
    NSIndexPath     *_index;
    Order           *_order;
}

@property id<ExtendServicePopupDelegate>            delegate;
@property (weak, nonatomic) IBOutlet JButton        *btConfirm;
@property (weak, nonatomic) IBOutlet PopupView      *popupView;
@property (weak, nonatomic) IBOutlet UITableView    *tbExtendService;

- (IBAction)didClickConfirmButton:(id)sender;

-(void)setTotalService:(NSArray*)totalservice;
-(void)setSelectedService:(NSArray*)selectedservice;

-(void)setOrderAttribute:(ORDER_ATTRIBUTE)attribute;
-(void)setIndexPath:(NSIndexPath*)index;
-(void)setOrder:(Order*)order;

@end

NS_ASSUME_NONNULL_END
