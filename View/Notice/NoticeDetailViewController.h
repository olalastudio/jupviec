//
//  NoticeDetailViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeDetailViewController : JViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *notifyImageView;
@property (weak, nonatomic) IBOutlet UITextView *notifyContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *notifyDateLB;
@property (strong, nonatomic) NSDictionary* notifyInfo;
@property (strong, nonatomic) NSData* imageData;

@end

NS_ASSUME_NONNULL_END
