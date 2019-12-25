//
//  DayLabel.h
//  JupViec
//
//  Created by KienVu on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DayLabelDelegate <NSObject>

-(void)didSelectDayLabel:(DAYINWEEK)dayinweek;
-(void)didUnSelectDayLabel:(DAYINWEEK)dayinweek;

@end

@interface DayLabel : UILabel
{
    BOOL    _selected;
}

@property id<DayLabelDelegate>  delegate;

@property DAYINWEEK dayInWeek;
@property BOOL  selected;

@end

NS_ASSUME_NONNULL_END
