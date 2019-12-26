//
//  HistoryViewController.h
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailOrderViewController.h"

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,DetailOrderViewDelegate>
{
    UINavigationController *naviController;
    NSDictionary *_definesCode;
}

@property (strong, nonatomic) User      *user;

@property (weak, nonatomic) IBOutlet UITableView *tbHistory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgSelection;

- (IBAction)didSelectHistorySegment:(id)sender;

-(void)setDefineCodeGetFromServer:(NSDictionary*)codes;

@end

NS_ASSUME_NONNULL_END
