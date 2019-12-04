//
//  HistoryViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UINavigationController *naviController;
}

@property (weak, nonatomic) IBOutlet UITableView *tbHistory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgSelection;

@end

NS_ASSUME_NONNULL_END
