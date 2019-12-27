//
//  DetailOrderViewController.m
//  JupViec
//
//  Created by KienVu on 12/2/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "DetailOrderViewController.h"
#import "RateViewController.h"
#import "JUntil.h"

#import "APIRequest.h"

@interface DetailOrderViewController ()

@end

@implementation DetailOrderViewController
@synthesize delegate = _delegate;
@synthesize user = _user;
@synthesize detailInfo = _detailInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [_txtContent setSelectable:NO];
}

-(void)loadView
{
    [super loadView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    [self updateContentView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setUser:(User *)user
{
    _user = user;
}

-(User*)user
{
    return _user;
}

-(void)setDetailInfo:(NSDictionary *)detailInfo
{
    _detailInfo = detailInfo;
}

-(NSDictionary*)detailInfo
{
    return _detailInfo;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)updateContentView
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    
    NSString *rqType = [_detailInfo objectForKey:ID_REQUEST_TYPE];
    NSAttributedString *tasktype = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Loại dịch vụ: %@\n\n",rqType]];
    
    [attributeStr appendAttributedString:tasktype];
    
    NSString *requester = [_detailInfo objectForKey:ID_REQUESTER];
    NSAttributedString *strrequester = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Số điện thoại: %@\n\n",requester]];
    
    [attributeStr appendAttributedString:strrequester];
    
    NSString *status = [_detailInfo objectForKey:ID_REQUEST_STATUS];
    NSAttributedString *strStatus = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Trạng Thái: %@\n\n",status]];
    
    [attributeStr appendAttributedString:strStatus];
    
    NSString *requestdate = [_detailInfo objectForKey:ID_UPDATE_DATE];
    NSAttributedString *strRequestdate = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Ngày đặt: %@\n\n",requestdate]];
    
    [attributeStr appendAttributedString:strRequestdate];
    
    NSString *location = [_detailInfo objectForKey:ID_LOCATION];
    NSAttributedString *strLocation = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Địa điểm: %@\n\n",location]];
    
    [attributeStr appendAttributedString:strLocation];
    
    NSString *price = [_detailInfo objectForKey:ID_TOTAL_PRICE];
    NSAttributedString *strPrice = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Tổng tiền: %@\n\n",price]];
    
    [attributeStr appendAttributedString:strPrice];
    
    [_txtContent setAttributedText:attributeStr];
    
    [self showStopButton];
    [self showRateButton];
}

-(void)showRateButton
{
    NSString *requestStatus = [_detailInfo objectForKey:ID_REQUEST_STATUS];
    
    if ([requestStatus isEqualToString:CODE_DADONDEP])
    {
        [_btRate setEnabled:YES];
    }
    else
    {
        [_btRate setEnabled:NO];
    }
}

-(void)showStopButton
{
    NSString *client_status = [_detailInfo objectForKey:ID_CLIENT_STATUS];
    
    if ([client_status isEqualToString:CODE_YEUCAUDICHVU])
    {
        [_btStopService setHidden:NO];
    }
    else
    {
        [_btStopService setHidden:YES];
    }
}

-(IBAction)didPressRateButton:(id)sender
{
    RateViewController *rateview = [self.storyboard instantiateViewControllerWithIdentifier:@"idrateview"];
    [rateview loadView];
    
    [rateview setUserToken:[_user userToken]];
    [rateview setIDService:[_detailInfo objectForKey:ID_SERVICE]];
    [rateview setServiceInfo:_detailInfo];
    
    [self.navigationController pushViewController:rateview animated:YES];
}

- (IBAction)didPressStopServiceButton:(id)sender
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    NSString *serviceID = [_detailInfo objectForKey:ID_SERVICE];
    NSString *token = [_user userToken];
    
    [apirequest requestAPICancelRequest:serviceID token:token completionHandler:^(NSDictionary * _Nullable resultDict, NSError * _Nonnull error)
    {
        if (error.code == 200)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleViewForStopOrder:resultDict];
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
}

#pragma mark - Delegate
-(void)handleViewForStopOrder:(NSDictionary*)resultDic
{    
    if (_delegate && [_delegate respondsToSelector:@selector(didStopOder:)])
    {
        [_delegate didStopOder:resultDic];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
