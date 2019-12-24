//
//  TimeSelectionTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/11/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "TimeSelectionTableViewCell.h"

@implementation TimeSelectionTableViewCell
@synthesize delegate = _delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
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
    
    [self showTime];
}

-(void)setIndexPath:(NSIndexPath *)index
{
    _indexPath = index;
}

- (IBAction)didPressWorkTimeButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeTimeSelection:index:)])
    {
        [_delegate didClickChangeTimeSelection:_ordeAttribute index:_indexPath];
    }
}

- (IBAction)didSelectWorkShiftSegment:(id)sender
{
    NSMutableDictionary *worktime;
    SHIFT_WORK  shiftwork = SHIFT_WORK_MORNING;
    
    switch ([_sgShiftWork selectedSegmentIndex]) {
        case SHIFT_WORK_MORNING:
        {
            NSString *startTime = @"08:00";
            NSString *endTime = @"11:30";
            worktime = [NSMutableDictionary dictionaryWithObjectsAndKeys:startTime,ATTRIBUTE_START_TIME, endTime, ATTRIBUTE_END_TIME, nil];
            shiftwork = SHIFT_WORK_MORNING;
        }
            break;
        case SHIFT_WORK_AFTERNOON:
        {
            NSString *startTime = @"13:00";
            NSString *endTime = @"16:30";
            
            worktime = [NSMutableDictionary dictionaryWithObjectsAndKeys:startTime,ATTRIBUTE_START_TIME, endTime, ATTRIBUTE_END_TIME, nil];
            shiftwork = SHIFT_WORK_AFTERNOON;
        }
            break;
        case SHIFT_WORK_EVENING:
        {
            NSString *startTime = @"17:00";
            NSString *endTime = @"20:30";
            
            worktime = [NSMutableDictionary dictionaryWithObjectsAndKeys:startTime,ATTRIBUTE_START_TIME, endTime, ATTRIBUTE_END_TIME, nil];
            shiftwork = SHIFT_WORK_EVENING;
        }
            break;
        default:
            break;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeWorkShift:workTime:index:)]) {
        [_delegate didClickChangeWorkShift:shiftwork workTime:worktime index:_indexPath];
    }
}

-(void)showTime
{
    NSMutableDictionary *worktime = [_order workTime];
    NSString *startTime = [worktime objectForKey:ATTRIBUTE_START_TIME];
    NSString *endTime = [worktime objectForKey:ATTRIBUTE_END_TIME];
    
    [_btWorkTimeValue setTitle:[NSString stringWithFormat:@"%@-%@",startTime,endTime] forState:UIControlStateNormal];
    
    switch ([_order workShift]) {
        case SHIFT_WORK_MORNING:
            [_sgShiftWork setSelectedSegmentIndex:SHIFT_WORK_MORNING];
            break;
        case SHIFT_WORK_AFTERNOON:
            [_sgShiftWork setSelectedSegmentIndex:SHIFT_WORK_AFTERNOON];
            break;
        case SHIFT_WORK_EVENING:
            [_sgShiftWork setSelectedSegmentIndex:SHIFT_WORK_EVENING];
            break;
        default:
            break;
    }
}
@end
