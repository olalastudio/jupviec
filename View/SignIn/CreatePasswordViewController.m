//
//  CreatePasswordViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "CreatePasswordViewController.h"
#import "APIRequest.h"

@interface CreatePasswordViewController ()

@end

@implementation CreatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtInputPassword setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//UITextFieldDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)didClickRegisterBtn:(id)sender {
    if ([[_txtInputPassword text] isEqualToString:[_txtReInputPassword text]])
    {
        APIRequest* apiRequest = [[APIRequest alloc]init];
        if (_intActionMode == MODE_FORGOT_PASSWORD)
        {
            [apiRequest requestAPIUpdatePassword:_strPhoneNum password:[_txtInputPassword text] token:_strToken completionHandler:^(User * _Nonnull user, NSError * _Nonnull error) {
                NSLog(@"change password success");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"idUserHomeVC" sender:self];
                });
            }];
        }
        else if (_intActionMode == MODE_REGISTER_NEW_ACC)
        {
            [apiRequest requestAPIRegister:_strPhoneNum password:[_txtInputPassword text] completionHandler:^(User * _Nonnull user, NSError * _Nonnull err) {
                if (err.code == 200)
                {
                    NSLog(@"Register success");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"idUserHomeVC" sender:self];
                    });
                }
            }];
        }
    }else{
        NSLog(@"password is not match");
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Nhập lại mật khẩu cần trùng khớp" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_txtReInputPassword setText:@""];
        }];
        [alertController addAction:alertAct];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}
@end
