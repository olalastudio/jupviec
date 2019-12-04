//
//  HomePromotionTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePromotionTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    TASK_TYPE       _taskType;
    SESSION_TYPE    _sessionType;
}

@property (weak, nonatomic) IBOutlet UICollectionView *clPromotionCode;


-(void)setTaskType:(TASK_TYPE)task;
-(void)setSessionType:(SESSION_TYPE)session;

-(TASK_TYPE)taskType;
-(SESSION_TYPE)sessionType;

@end

NS_ASSUME_NONNULL_END
