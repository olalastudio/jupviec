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

-(void)setHistoryData:(NSDictionary *)historyData
{
    _historyData = historyData;
    
    [self reloadContentView];
}

-(NSDictionary*)historyData
{
    return _historyData;
}

-(void)reloadContentView
{
    NSString *requestStatus = [_historyData objectForKey:ID_REQUEST_STATUS];
    [_txtStatus setText:requestStatus];
    
    NSString *updateDate = [_historyData objectForKey:ID_UPDATE_DATE];
    [_txtDate setText:updateDate];
    
    NSString *workHour = [_historyData objectForKey:ID_WORKING_HOUR];
    NSString *workTime = [_historyData objectForKey:ID_WORKING_TIME];
    
    double startTime = [JUntil timeNumberFromString:workHour];
    double endTime = startTime + [workTime doubleValue];
    
    NSString *strEndTime = [JUntil timeStringFromNumber:endTime];
    [_txtWorkTime setText:[NSString stringWithFormat:@"%@ - %@",workHour, strEndTime]];
    
    NSString *strLocation = [_historyData objectForKey:ID_LOCATION];
    [_txtWorkAddress setText:strLocation];
    
    double totalMoney = [[_historyData objectForKey:ID_TOTAL_PRICE] doubleValue];
    [_txtTotalMoney setText:[NSString stringWithFormat:@"%0.3fđ",totalMoney]];
}
@end
