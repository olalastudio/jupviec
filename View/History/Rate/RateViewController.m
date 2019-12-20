//
//  RateViewController.m
//  JupViec
//
//  Created by KienVu on 12/19/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "RateViewController.h"
#import "APIRequest.h"
#import "CommonDefines.h"

@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Đánh giá dịch vụ"];
}

-(void)setUserToken:(NSString*)token
{
    _token = token;
}

-(void)setIDService:(NSString*)idservice
{
    _idservice = idservice;
}

-(void)setServiceInfo:(NSDictionary *)serviceInfo
{
    _serviceInfo = serviceInfo;
    
    NSNumber *ratescore = [_serviceInfo objectForKey:ID_RATE_SCORE];
    NSString *comment = [_serviceInfo objectForKey:ID_FEEDBACK];
    
    if (ratescore > 0) {
        [_btRate setEnabled:NO];
        [_txtComment setText:comment];
    }
    else{
        [_btRate setEnabled:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didPressRateButton:(id)sender
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    NSString *content = [_txtComment text];
    NSDictionary *rateInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:5], @"rate_score", content, @"content", nil];
    
    [apirequest requestAPIRateService:_token idService:_idservice rateServiceInfo:rateInfo completionHandler:^(NSDictionary * _Nullable resultDict, NSError * _Nonnull error) {
        
        if (error.code == 200) {
            NSLog(@"rate service successful %@",resultDict);
        }
        else{
            NSLog(@"rate service error %@",error);
        }
    }];
}
@end
