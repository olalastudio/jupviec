//
//  HomePromotionTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"
#import "JUntil.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomePromotionProtocol <NSObject>

-(void)didSelectPromotionCode:(NSDictionary*)promotioncode;

@end

@interface HomePromotionTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    TASK_TYPE       _taskType;
    SESSION_TYPE    _sessionType;
    NSMutableArray  *_promotionArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *clPromotionCode;

@property id<HomePromotionProtocol> delegate;

-(void)setTaskType:(TASK_TYPE)task;
-(void)setSessionType:(SESSION_TYPE)session;
-(void)setPromotion:(NSMutableArray*)promotions;

-(TASK_TYPE)taskType;
-(SESSION_TYPE)sessionType;
-(NSMutableArray*)promotions;

@end

NS_ASSUME_NONNULL_END
