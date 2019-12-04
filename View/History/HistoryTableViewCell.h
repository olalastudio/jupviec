//
//  HistoryTableViewCell.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryTableViewCell : UITableViewCell

- (IBAction)didClickCompleteButton:(id)sender;
- (IBAction)didClickPendingButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
