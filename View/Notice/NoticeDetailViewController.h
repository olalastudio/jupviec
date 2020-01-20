//
//  NoticeDetailViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"

@class JView;

NS_ASSUME_NONNULL_BEGIN

@interface NoticeDetailViewController : JViewController

@property (weak, nonatomic) IBOutlet JView          *contentView;
@property (weak, nonatomic) IBOutlet UILabel        *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView    *notifyImageView;
@property (weak, nonatomic) IBOutlet UILabel        *contentLB;
@property (weak, nonatomic) IBOutlet UILabel        *notifyDateLB;
@property (weak, nonatomic) IBOutlet UIView         *separatorline;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewHeightConstraint;


@property (strong, nonatomic) NSDictionary          *notifyInfo;
@property (strong, nonatomic) NSData                *imageData;

@end

NS_ASSUME_NONNULL_END
