//
//  TimeSelectionTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "TimeSelectionTableViewCell.h"
#import "JTextView.h"
#import "JUntil.h"

@implementation TimeSelectionTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_workTime setDelegate:self];
    [_workHour setDelegate:self];
    
    [_workTime setShowsVerticalScrollIndicator:NO];
    [_workTime setShowsHorizontalScrollIndicator:NO];
    [_workTime setScrollEnabled:NO];
    
    [_workHour setShowsVerticalScrollIndicator:NO];
    [_workHour setShowsHorizontalScrollIndicator:NO];
    [_workHour setScrollEnabled:NO];
    
    [_workTime setRestorationIdentifier:@"idworktime"];
    [_workHour setRestorationIdentifier:@"idworkhour"];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [_txtWorkHour setTextColor:UIColorFromRGB(0x000000)];
    [_txtWorkTime setTextColor:UIColorFromRGB(0x000000)];
    [_workHour setTextColor:UIColorFromRGB(0xACB3BF)];
    [_workTime setTextColor:UIColorFromRGB(0xACB3BF)];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOderAttribute:(ORDER_ATTRIBUTE)attribute
{
    _ordeAttribute = attribute;
}

-(void)setOrder:(Order *)order
{
    _order = order;
    
    if ([order orderType] == TYPE_TONGVESINH || [order orderType] == TYPE_JUPSOFA)
    {
        [_workHour setHidden:YES];
        [_txtWorkHour setHidden:YES];
    }
    else
    {
        [_workHour setHidden:NO];
        [_txtWorkHour setHidden:NO];
    }
    
    [self showTime];
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

-(void)showTime
{
    NSDate *worktime = [_order workTime];

    if (_ordeAttribute == ATTRIBUTE_GIOKHAOSAT) {
        worktime = [_order timeOfExamine];
    }
    
    NSInteger hour = [JUntil hourFromDate:worktime];
    NSInteger minute = [JUntil minuteFromDate:worktime];
    double workhour = [_order workHour];
    
    [_workTime setText:[NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute]];
    [_workHour setText:[NSString stringWithFormat:@"%.1f",workhour]];
}

#pragma mark - TextView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([[textView restorationIdentifier] isEqualToString:@"idworktime"])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickWorkTimeSelection:index:)])
        {
            [_delegate didClickWorkTimeSelection:_ordeAttribute index:_indexPath];
        }
    }
    else if ([[textView restorationIdentifier] isEqualToString:@"idworkhour"])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickWorkTimeSelection:index:)])
        {
            [_delegate didClickWorkHourSelection:_ordeAttribute index:_indexPath];
        }
    }
    
    return NO;
}
@end
