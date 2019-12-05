//
//  HomeTaskTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomeTaskTableViewCell.h"

@implementation HomeTaskTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // shadow
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:192/255.0f green:192/255.0f blue:192/255.0f alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 6.0;
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 12;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 15;
    frame.origin.y -= 5;
    frame.size.width -= 2*15;
    frame.size.height -= 2*5;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTaskType:(TASK_TYPE)task
{
    _taskType = task;
    
    [self reloadViewContent];
}
-(void)setSessionType:(SESSION_TYPE)session
{
    _sessionType = session;
}

-(TASK_TYPE)taskType
{
    return _taskType;
}
-(SESSION_TYPE)sessionType
{
    return _sessionType;
}

-(void)reloadViewContent
{
    switch (_taskType) {
        case TYPE_DUNGLE:
            [_imgIcon setImage:[UIImage imageNamed:@"add-2"]];
            [_txtTitle setText:@"Dùng Lẻ"];
            [_txtDescription setText:@"Theo giờ, khi có nhu cầu"];
            break;
        case TYPE_DUNGDINHKY:
            [_imgIcon setImage:[UIImage imageNamed:@"calendar-1"]];
            [_txtTitle setText:@"Dùng định kỳ"];
            [_txtDescription setText:@"Hàng tuần, giá ưu đãi"];
            break;
        case TYPE_TONGVESINH:
            [_imgIcon setImage:[UIImage imageNamed:@"help"]];
            [_txtTitle setText:@"Tổng vệ sinh"];
            [_txtDescription setText:@"Làm sạch chuyên sâu"];
            break;
        case TYPE_JUPSOFA:
            [_imgIcon setImage:[UIImage imageNamed:@"diploma"]];
            [_txtTitle setText:@"JupSofa"];
            [_txtDescription setText:@"Giặt sofa/ nệm/ thảm/ rèm"];
            break;
        default:
            break;
    }
}

@end
