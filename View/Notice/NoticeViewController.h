//
//  NoticeViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "CommonDefines.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeViewController : JViewController <UITableViewDelegate,UITableViewDataSource>
{
    NOTICE_CHOISE   _selectedNotice;
}

@property (strong, nonatomic) User  *user;

@property (weak, nonatomic) IBOutlet UITableView *tbNotice;
@property (weak, nonatomic) IBOutlet UIView *categoriesSelectionView;
@property (weak, nonatomic) IBOutlet UIView *separationView;
@property (weak, nonatomic) IBOutlet UIButton *btNotice;
@property (weak, nonatomic) IBOutlet UIButton *btPromotion;

- (IBAction)didSelectNoticeType:(id)sender;
- (IBAction)didSelectPromotionType:(id)sender;

-(void)showCouponView;
-(void)showNoticeView;
@end

NS_ASSUME_NONNULL_END
