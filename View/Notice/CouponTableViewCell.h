//
//  CouponTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponTableViewCell : UITableViewCell
{
    NSDictionary* _couponInfo;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;

- (void)setNotifyCoupon:(NSDictionary*)notifyInfo;
@end

NS_ASSUME_NONNULL_END
