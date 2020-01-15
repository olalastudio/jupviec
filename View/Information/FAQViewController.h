//
//  FAQViewController.h
//  JupViec
//
//  Created by Khanhlt on 1/15/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAQViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FAQTableViewCellDelegate>
{
    NSArray* titlesArr;
    NSArray* contentsArr;
    FAQTableViewCell* _faqCell;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
