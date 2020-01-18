//
//  FeedbackViewController.h
//  JupViec
//
//  Created by Khanhlt on 1/16/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JViewController.h"
#import "User.h"
#import "APIRequest.h"
#import "JUntil.h"
#import "LoadingViewController.h"

@class JTextView;

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackViewController : JViewController
@property (weak, nonatomic) IBOutlet UILabel *feedbackTitle;
@property (weak, nonatomic) IBOutlet JTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *feedbackBtn;
@property (strong, nonatomic) User* user;
- (IBAction)didClickSendFeedbackButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
