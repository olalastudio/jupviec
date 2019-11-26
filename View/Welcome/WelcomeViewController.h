//
//  WelcomeViewController.h
//  JupViec
//
//  Created by KienVu on 11/25/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WelcomeViewControllerDelegate <NSObject>

-(void)getStart;

@end

@interface WelcomeViewController : UIViewController

@property (assign, nonatomic) NSInteger      index;
@property id<WelcomeViewControllerDelegate>  delegate;

@property (weak, nonatomic) IBOutlet UILabel *txtWelcome;
@property (weak, nonatomic) IBOutlet UIButton *btskip;
@property (weak, nonatomic) IBOutlet UIButton *btStart;

- (IBAction)didPressSkipButton:(id)sender;
- (IBAction)didPressStartButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
