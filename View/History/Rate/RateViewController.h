//
//  RateViewController.h
//  JupViec
//
//  Created by KienVu on 12/19/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RateViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *lbRateScore;

@property (weak, nonatomic) IBOutlet UILabel *lbComment;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (weak, nonatomic) IBOutlet UIButton *btRate;

- (IBAction)didPressRateButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
