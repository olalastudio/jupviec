//
//  JAlertPopupController.m
//  JupViec
//
//  Created by KienVu on 1/13/20.
//  Copyright © 2020 Olala. All rights reserved.
//

#import "JAlertPopupController.h"
#import "JButton.h"
#import "PopupView.h"
#import "CommonDefines.h"

@interface JAlertPopupController ()

@end

@implementation JAlertPopupController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_txtMessage setTextColor:UIColorFromRGB(0x000000)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_txtMessage setText:_message];
    if (_confirmTitle) {
        [_btConfirm setTitle:_confirmTitle forState:UIControlStateNormal];
    }
    
    self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    [self.view setBackgroundColor:[UIColor colorWithRed:85.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:0.38]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
           self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.99, 0.99);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.popupView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            } completion:^(BOOL finished) {
                self.popupView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setMessage:(NSString*)message
{
    _message = message;
}

-(void)setConfirmButtonTitle:(NSString*)title
{
    _confirmTitle = title;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressConfirmPopupButton:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didCloseAlertPopupWithCode:)])
    {
        [_delegate didCloseAlertPopupWithCode:ACTION_OK];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
