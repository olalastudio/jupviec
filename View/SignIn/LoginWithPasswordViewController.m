//
//  LoginWithPasswordViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "LoginWithPasswordViewController.h"
#import "APIRequest.h"

@interface LoginWithPasswordViewController ()

@end

@implementation LoginWithPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtInputUserPhone setDelegate:self];
    [_txtInputUserPass setDelegate:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma - UITextFielDelegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)showPopupNewUserPhone
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"So dien thoai chua duoc dang ky" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAct];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)showPopupIncorrectUserPassword
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Mat khau chua chinh xac" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAct];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma - Actions
- (IBAction)didClickedFogetPassword:(id)sender {
}

- (IBAction)didClickedRegisterNewAcc:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"idLoginToNewRegister" sender:self];
    });
}

- (IBAction)didClickedLogin:(id)sender {
    if ([_txtInputUserPhone text] && [_txtInputUserPass text])
    {
        strUserPass = [_txtInputUserPass text];
        strUserphone = [_txtInputUserPhone text];
        APIRequest *request = [[APIRequest alloc]init];
        [request requestAPILogin:strUserphone password:strUserPass completionHandler:^(NSString * _Nonnull token, NSError * _Nonnull error) {
            if (error.code == 200)
            {
                NSLog(@"lofin success: go to home view");
                
            } else if (error.code == 404)
            {
                NSLog(@"phone number is not registed");
                
            }
        }];
    }
}
@end
