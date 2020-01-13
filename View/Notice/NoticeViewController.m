//
//  NoticeViewController.m
//  JupViec
//
//  Created by KienVu on 12/3/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "CouponTableViewCell.h"
#import "NoticeDetailViewController.h"
#import "APIRequest.h"
#import "CommonDefines.h"
#import "JUntil.h"

@interface NoticeViewController ()
{
    NSMutableArray *_listNotices;
    NSMutableArray *_listCoupons;
}

@end

@implementation NoticeViewController
@synthesize user = _user;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_sgSelection setBackgroundColor:[UIColor clearColor]];
    [_sgSelection setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont fontWithName:@"Roboto-Regular" size:15]} forState:UIControlStateNormal];
    [_sgSelection setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0xFF7E46), NSFontAttributeName: [UIFont fontWithName:@"Roboto-Regular" size:15]} forState:UIControlStateSelected];
    
    _listNotices = [[NSMutableArray alloc] initWithCapacity:0];
    _listCoupons = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_tbNotice registerNib:[UINib nibWithNibName:@"NoticeCell" bundle:nil] forCellReuseIdentifier:@"idnoticecell"];
    [_tbNotice registerNib:[UINib nibWithNibName:@"CouponCell" bundle:nil] forCellReuseIdentifier:@"idcouponcell"];
    
    [_tbNotice setDelegate:self];
    [_tbNotice setDataSource:self];
    
    [_tbNotice setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Comfortaa-Regular" size:20]}];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
    [self showSelectedList];
    
    if ([_listNotices count] == 0) {
        [self getNotice];
    }
    
    if ([_listCoupons count] == 0) {
        [self getCoupon];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setUser:(User *)user
{
    _user = user;
}

- (User *)user
{
    return _user;
}

-(void)getNotice
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    
    [apirequest requestAPIGetNotifiesWithType:[_user userToken] notifyType:NOTIFIES_TYPE_NOTIFY completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error) {
        if (error.code == 200) {
            [self showNotice:resultDict];
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

-(void)getCoupon
{
    APIRequest *apirequest = [[APIRequest alloc] init];
    [apirequest requestAPIGetNotifiesWithType:[_user userToken] notifyType:NOTIFIES_TYPE_PROMOTION completionHandler:^(NSArray * _Nullable resultDict, NSError * _Nonnull error) {
        if (error.code == 200) {
            [self showCoupon:resultDict];
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

-(void)showNotice:(NSArray*)notices
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        _listNotices = [NSMutableArray arrayWithArray:notices];
        
         [self showSelectedList];
        [_tbNotice reloadData];
    });
}

-(void)showCoupon:(NSArray*)notices
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        _listCoupons = [NSMutableArray arrayWithArray:notices];
        
        [self showSelectedList];
        [_tbNotice reloadData];
    });
}

-(void)showCouponView
{
    _selectedNotice = NOTICE_CHOISE_COUPON;
}

-(void)showNoticeView
{
    _selectedNotice = NOTICE_CHOISE_NOTICE;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelectNoticeType:(id)sender
{
    if ([_sgSelection selectedSegmentIndex] == 0)
    {
        _selectedNotice = NOTICE_CHOISE_NOTICE;
    }
    else
    {
        _selectedNotice = NOTICE_CHOISE_COUPON;
    }
    
    [_tbNotice reloadData];
}

-(void)showSelectedList
{
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
    {
        [_sgSelection setSelectedSegmentIndex:0];
    }
    else
    {
        [_sgSelection setSelectedSegmentIndex:1];
    }
}

-(NSMutableArray*)getSelectedList
{
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
       {
           return _listNotices;
       }
       else if (_selectedNotice == NOTICE_CHOISE_COUPON)
       {
           return _listCoupons;
       }
    
    return [[NSMutableArray alloc] initWithCapacity:0];
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getSelectedList] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
    {
        NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idnoticecell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setNoticeInfo:[_listNotices objectAtIndex:indexPath.row]];
        
        return cell;
    }
    else if (_selectedNotice == NOTICE_CHOISE_COUPON)
    {
        CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idcouponcell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setNotifyCoupon:[_listCoupons objectAtIndex:indexPath.row]];
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
    {
        return 130;
    }
    else if (_selectedNotice == NOTICE_CHOISE_COUPON)
    {
        return 167;
    }
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"idnoticedetail"];
    if (_selectedNotice == NOTICE_CHOISE_NOTICE)
    {
        [detailViewController setNotifyInfo:[_listNotices objectAtIndex:indexPath.row]];
    }
    else if (_selectedNotice == NOTICE_CHOISE_COUPON)
    {
        CouponTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSData* imageData = [cell imageData];
        [detailViewController setNotifyInfo:[_listCoupons objectAtIndex:indexPath.row]];
        [detailViewController setImageData:imageData];
    }
    
    UIViewController *topview = [self.navigationController topViewController];
    
    if (![topview isKindOfClass:[NoticeDetailViewController class]])
    {
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}
@end
