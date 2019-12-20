//
//  HistoryViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UINavigationController *naviController;
}

@property (strong, nonatomic) User      *user;

@property (weak, nonatomic) IBOutlet UITableView *tbHistory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgSelection;

- (IBAction)didSelectHistorySegment:(id)sender;

@end

NS_ASSUME_NONNULL_END
