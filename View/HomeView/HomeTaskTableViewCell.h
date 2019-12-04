//
//  TaskTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTaskTableViewCell : UITableViewCell
{
    TASK_TYPE       _taskType;
    SESSION_TYPE    _sessionType;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtDescription;


-(void)setTaskType:(TASK_TYPE)task;
-(void)setSessionType:(SESSION_TYPE)session;

-(TASK_TYPE)taskType;
-(SESSION_TYPE)sessionType;

@end

NS_ASSUME_NONNULL_END
