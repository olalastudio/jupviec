//
//  JAlertPopupController.h
//  JupViec
//
//  Created by KienVu on 1/13/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefines.h"

@class JButton;
@class PopupView;

NS_ASSUME_NONNULL_BEGIN

@protocol JAlertPopupDelegate <NSObject>

-(void)didCloseAlertPopupWithCode:(POPUP_ACTION)code;

@end

@interface JAlertPopupController : UIViewController
{
    NSString *_message;
    NSString *_confirmTitle;
}

@property id<JAlertPopupDelegate>               delegate;
@property (weak, nonatomic) IBOutlet PopupView  *popupView;
@property (weak, nonatomic) IBOutlet UILabel    *txtMessage;
@property (weak, nonatomic) IBOutlet JButton    *btConfirm;

-(void)setMessage:(NSString*)message;
-(void)setConfirmButtonTitle:(NSString*)title;

- (IBAction)didPressConfirmPopupButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
