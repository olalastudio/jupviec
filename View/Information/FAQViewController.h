//
//  FAQViewController.h
//  JupViec
//
//  Created by Khanhlt on 1/15/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQTableViewCell.h"
#import "JViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController : JViewController <UITableViewDelegate, UITableViewDataSource, FAQTableViewCellDelegate>
{
    NSArray* titlesArr;
    NSArray* contentsArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* faqArr;

@end

NS_ASSUME_NONNULL_END
