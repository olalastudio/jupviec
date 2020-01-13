//
//  NoticeTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeTableViewCell : UITableViewCell
{
    NSDictionary    *_noticeInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtContent;
@property (weak, nonatomic) IBOutlet UILabel *txtDate;
@property (weak, nonatomic) IBOutlet UIView *separateline;

-(void)setNoticeInfo:(NSDictionary*)noticeInfo;
@end

NS_ASSUME_NONNULL_END
