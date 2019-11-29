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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressCloseButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)didPressNextButton:(id)sender {
    NSString *strPhone = @"968300660";  //[_txtPhone text];
    NSString *strAPI = [NSString stringWithFormat:API_GETOTP,ADDRESS_SERVER];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:strAPI];
    NSURLQueryItem *phone = [NSURLQueryItem queryItemWithName:@"phone" value:strPhone];
    NSURLQueryItem *type = [NSURLQueryItem queryItemWithName:@"type" value:@"register"];
    
    components.queryItems = @[phone, type];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:components.URL];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *responseData = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *strResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"OTP %@",strResponse);
    }];
    
    [responseData resume];
}
@end
