//
//  NoticeTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeTableViewCell.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setNoticeInfo:(NSDictionary *)noticeInfo
{
    _noticeInfo = noticeInfo;
    
    [self reloadContentView];
}

-(void)reloadContentView
{
    NSString *title = [_noticeInfo objectForKey:@"title"];
    NSString *content = [_noticeInfo objectForKey:@"content"];
    NSString *date = [_noticeInfo objectForKey:@"updated_at"];
    
    [_txtTitle setText:title];
    [_txtContent setText:content];
    [_txtDate setText:date];
}
@end
