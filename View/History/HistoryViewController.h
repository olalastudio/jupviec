//
//  HistoryViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "DetailOrderViewController.h"
#import "CommonDefines.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : JViewController <UITableViewDelegate, UITableViewDataSource,DetailOrderViewDelegate>
{
    UINavigationController  *naviController;
    NSDictionary            *_definesCode;
}

@property (strong, nonatomic) User      *user;

@property (weak, nonatomic) IBOutlet UITableView *tbHistory;

-(void)setDefineCodeGetFromServer:(NSDictionary*)codes;
-(void)addCompleteOrder:(NSDictionary*)orderInfo;
@end

NS_ASSUME_NONNULL_END
