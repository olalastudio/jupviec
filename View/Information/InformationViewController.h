//
//  InformationViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InformationViewController : JViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tbInformation;

@end

NS_ASSUME_NONNULL_END
