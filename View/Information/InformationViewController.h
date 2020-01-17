//
//  InformationViewController.h
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "FAQViewController.h"
#import "APIRequest.h"
#import "FeedbackViewController.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface InformationViewController : JViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _informationArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tbInformation;
@property (strong, nonatomic) User* user;

@end

NS_ASSUME_NONNULL_END
