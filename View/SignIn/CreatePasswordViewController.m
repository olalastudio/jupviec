//
//  CreatePasswordViewController.m
//  JupViec
//
//  Created by KienVu on 11/29/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "CreatePasswordViewController.h"
#import "APIRequest.h"
#import "JButton.h"

@interface CreatePasswordViewController ()
{
    NSInteger keyboardheight;
}
@end

@implementation CreatePasswordViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.layer.masksToBounds = YES;
    
    [_txtInputPassword setDelegate:self];
    
    [_txtInputPassword setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_txtReInputPassword setTintColor:UIColorFromRGB(0x5C5C5C)];
    [_txtInputPasswordTitle setTextColor:UIColorFromRGB(0x5C5C5C)];
    [_txtReInputPasswordTitle setTextColor:UIColorFromRGB(0x5C5C5C)];
    
    keyboardheight = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [self registerFromKeyboardNotification];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self unregisterFromKeyboardNotification];
}

-(void)registerFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)unregisterFromKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
    
    keyboardheight = beginrect.origin.y - endrect.origin.y;
    
    CGRect registernowrect = [_btnRegister frame];
    registernowrect.origin.y -= keyboardheight;
    [_btnRegister setFrame:registernowrect];
    
}

-(void)keyboardDidHide:(NSNotification*)notification
{
    NSDictionary *userinfo = [notification userInfo];
    NSValue *keyboardbeginrect = [userinfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *keyboardendrect = [userinfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginrect = [keyboardbeginrect CGRectValue];
    CGRect endrect = [keyboardendrect CGRectValue];
    
    keyboardheight = endrect.origin.y - beginrect.origin.y;
    
    CGRect rect = [_btnRegister frame];
    if ((rect.origin.y + keyboardheight) < [_btnRegister superview].frame.size.height) {
        rect.origin.y += keyboardheight;
    }
    [_btnRegister setFrame:rect];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (void)requestLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
            APIRequest* apiRequest = [[APIRequest alloc]init];
            NSString *password = [self.txtInputPassword text];
            
            [apiRequest requestAPILogin:self.strPhoneNum password:password completionHandler:^(NSString * _Nullable token, NSError * _Nonnull error)
            {
                if (error.code == 200)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setStrToken:token];
                        [self.user setUserToken:token];
                        
                        for (UIViewController *vc in [self.navigationController viewControllers]) {
                            
                            if ([vc isKindOfClass:[HomeViewController class]]) {
                                [(HomeViewController*)vc setUser:self.user];
                                break;
                            }
                        }
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }
                else if (error.code == RESPONSE_CODE_NODATA)
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_NODATA];
                }
                else if (error.code == RESPONSE_CODE_TIMEOUT)
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
                }
                else
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
                }
            }];
     });
}

- (IBAction)didClickRegisterBtn:(id)sender
{
    [self.view endEditing:YES];
    
    if ([[_txtInputPassword text] isEqualToString:[_txtReInputPassword text]])
    {
        APIRequest* apiRequest = [[APIRequest alloc]init];
        if (_intActionMode == MODE_FORGOT_PASSWORD)
        {
            [apiRequest requestAPIUpdatePassword:_strPhoneNum password:[_txtInputPassword text] token:_strToken completionHandler:^(User * _Nullable user, NSError * _Nonnull error) {
                if (error.code == 200)
                {
                    NSLog(@"change password success");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"idUserHomeVC" sender:self];
                    });
                }
                else if (error.code == 204)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"no content account with phone" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:alertAct];
                        [self presentViewController:alertController animated:YES completion:nil];
                    });
                }
                else if (error.code == RESPONSE_CODE_TIMEOUT)
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
                }
                else
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
                }
            }];
        }
        else if (_intActionMode == MODE_REGISTER_NEW_ACC)
        {
            [apiRequest requestAPIRegister:_strPhoneNum password:[_txtInputPassword text] completionHandler:^(User * _Nonnull user, NSError * _Nullable err) {
                if (err.code == 200)
                {
                    NSLog(@"Register success");
                    self.user = user;
                    //login to get token
                    [self requestLogin];
                }
                else if (err.code == 400)
                {
                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Popup" message:@"Invalid data or phone existed" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *alertAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:alertAct];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:alertController animated:YES completion:nil];
                    });
                }
                else if (err.code == RESPONSE_CODE_TIMEOUT)
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_TIMEOUT];
                }
                else
                {
                    [JUntil showPopup:self responsecode:RESPONSE_CODE_OTHER];
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
