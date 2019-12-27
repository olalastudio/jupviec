//
//  HistoryTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell
@synthesize historyData = _historyData;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDefineCodeGetFromServer:(NSMutableDictionary *)codes
{
    _definesCode = [[NSDictionary alloc] initWithDictionary:codes];
}

-(void)setHistoryData:(NSDictionary *)historyData
{
    _historyData = historyData;
    
    [self reloadContentView];
}

-(NSDictionary*)historyData
{
    return _historyData;
}

-(NSString*)stringDisplayWithStatusID:(NSString*)serverID code:(NSString*)serverCode
{
    NSArray* serverIDs = [_definesCode objectForKey:serverID];
    
    if ([serverCode isEqualToString:CODE_DANGYEUCAU] || [serverCode isEqualToString:CODE_DANGSAPXEP] || [serverCode isEqualToString:CODE_DASAPXEP])
    {
        [_txtStatus setBackgroundColor:UIColorFromRGB(0x04C400)];
    }
    else if ([serverCode isEqualToString:CODE_DANGDONDEP])
    {
        [_txtStatus setBackgroundColor:UIColorFromRGB(0xFF8F60)];
    }
    else if ([serverCode isEqualToString:CODE_DADONDEP])
    {
        [_txtStatus setBackgroundColor:UIColorFromRGB(0x8E1DE8)];
    }
    else
    {
        [_txtStatus setBackgroundColor:UIColorFromRGB(0xACB3BF)];
    }
    
    for (NSDictionary* item in serverIDs)
    {
        if ([[item objectForKey:ID_CODE] isEqualToString:serverCode])
        {
            return [item objectForKey:ID_NAME];
        }
    }
    
    return @"";
}

-(void)reloadContentView
{
    NSString *requestStatus = [_historyData objectForKey:ID_REQUEST_STATUS];
    [_txtStatus setText:[self stringDisplayWithStatusID:ID_REQUEST_STATUS code:requestStatus]];
    
    NSString *strDate = [_historyData objectForKey:ID_UPDATE_DATE];
    NSDate *updateDate = [JUntil dateFromString:strDate];
    [_txtDate setText:[JUntil stringFromDate:updateDate]];
    
    NSString *workHour = [_historyData objectForKey:ID_WORKING_HOUR];
    NSString *workTime = [_historyData objectForKey:ID_WORKING_TIME];
    
    [_txtWorkTime setText:[NSString stringWithFormat:@"Giờ làm việc: %@ - Thời gian: %@h",workHour, workTime]];
    
    NSString *strLocation = [_historyData objectForKey:ID_LOCATION];
    [_txtWorkAddress setText:strLocation];
    
    NSString *clientStatus = [_historyData objectForKey:ID_CLIENT_STATUS];
    [_txtClientStatus setText:clientStatus];
    
    double totalMoney = [[_historyData objectForKey:ID_TOTAL_PRICE] doubleValue];
    [_txtTotalMoney setText:[NSString stringWithFormat:@"%0.3fđ",totalMoney]];
}
@end
