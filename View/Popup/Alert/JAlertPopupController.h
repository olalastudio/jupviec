//
//  JAlertPopupController.h
//  JupViec
//
//  Created by KienVu on 1/13/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JButton;
@class PopupView;

NS_ASSUME_NONNULL_BEGIN

@interface JAlertPopupController : UIViewController

@property (weak, nonatomic) IBOutlet PopupView *popupView;
@property (weak, nonatomic) IBOutlet UILabel *txtMessage;
@property (weak, nonatomic) IBOutlet JButton *btConfirm;

- (IBAction)didPressConfirmPopupButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
