//
//  NoticeTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeTableViewCell.h"
#import "CommonDefines.h"
#import "JUntil.h"

@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_txtTitle setTextColor:UIColorFromRGB(0x000000)];
    [_txtContent setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_txtDate setTextColor:UIColorFromRGB(0xACB3BF)];
    [_separateline setBackgroundColor:UIColorFromRGB(0xF0F0F0)];
    
    [self setBackgroundColor:[UIColor whiteColor]];
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
    NSString *strdate = [_noticeInfo objectForKey:@"expired_date"];
    
    [_txtTitle setText:title];
    [_txtContent setText:content];
    
    NSDate *date = [JUntil dateFromString:strdate];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE, dd/MM/yyyy"];
    [format setLocale:[NSLocale localeWithLocaleIdentifier:@"vi_VN"]];
    
    [_txtDate setText:[format stringFromDate:date]];
}
@end
