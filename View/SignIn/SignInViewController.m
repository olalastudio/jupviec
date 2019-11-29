//
//  SignInViewController.m
//  JupViec
//
//  Created by KienVu on 11/26/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_txtPhone setDelegate:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//TextField delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)didSuccessGetOTP:(NSString*)strOTP
{
    [self performSegueWithIdentifier:@"idcheckotp" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (IBAction)didPressNextButton:(id)sender {
    if ([_txtPhone text])
    {
        APIRequest* apiRequest = [[APIRequest alloc]init];
        [apiRequest requestGetOTP:[_txtPhone text] completionHandler:^(NSString * _Nonnull otpStr, NSError * _Nonnull err) {
            NSLog(@"otp: %@", otpStr);
            [self didSuccessGetOTP:otpStr];
            //handle
        }];
    }
}
@end
