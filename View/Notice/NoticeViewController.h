//
//  NoticeViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) User  *user;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sgSelection;
@property (weak, nonatomic) IBOutlet UITableView *tbNotice;
@property (weak, nonatomic) IBOutlet UITableView *tbCoupon;

- (IBAction)didSelectNoticeType:(id)sender;

@end

NS_ASSUME_NONNULL_END
