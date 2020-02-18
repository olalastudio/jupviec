//
//  HomeTaskTableViewCell.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "HomeTaskTableViewCell.h"
#import "CommonDefines.h"

@implementation HomeTaskTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // shadow
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.25].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 4.0);
    self.layer.shadowOpacity = 4;
    self.layer.shadowRadius = 4.0;
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 10;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [_txtTitle setTextColor:UIColorFromRGB(0xE4672D)];
    [_txtDescription setTextColor:UIColorFromRGB(0x5C5C5C)];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x += 18;
    frame.origin.y -= 5;
    frame.size.width -= 16 + 24;
    frame.size.height -= 5 + 25;
    
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

-(void)setDisplayName:(NSString *)name
{
    _displayName = name;
    
    [_txtTitle setText:_displayName];
}

-(TASK_TYPE)taskType
{
    return _taskType;
}
-(SESSION_TYPE)sessionType
{
    return _sessionType;
}

-(NSString*)displayName
{
    return _displayName;
}

-(void)reloadViewContent
{
    switch (_taskType) {
        case TYPE_DUNGLE:
            [_imgIcon setImage:[UIImage imageNamed:@"dungle.png"]];
            [_txtTitle setText:@"Dùng lẻ"];
            [_txtDescription setText:@"Sử dụng dịch vụ theo giờ khi có nhu cầu"];
            break;
        case TYPE_DUNGDINHKY:
            [_imgIcon setImage:[UIImage imageNamed:@"dungdinhky.png"]];
            [_txtTitle setText:@"Dùng định kỳ"];
            [_txtDescription setText:@"Sử dụng dịch vụ theo giờ định kỳ trong tuần"];
            break;
        case TYPE_TONGVESINH:
            [_imgIcon setImage:[UIImage imageNamed:@"tongvesinh.png"]];
            [_txtTitle setText:@"Tổng vệ sinh"];
            [_txtDescription setText:@"Vệ sinh tổng hợp chuyên sâu"];
            break;
        case TYPE_JUPSOFA:
            [_imgIcon setImage:[UIImage imageNamed:@"giatsofa.png"]];
            [_txtTitle setText:@"Giặt sofa, rèm"];
            [_txtDescription setText:@"Làm sạch sofa,rem,là,ủi theo yêu cầu"];
            break;
        default:
            break;
    }
}

@end
